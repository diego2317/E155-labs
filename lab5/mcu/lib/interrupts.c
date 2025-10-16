// interrupts.c
// interrupt functions + quadrature decoding
// Author: Diego Weiss
// Email: dweiss@hmc.edu
// 10/8/2025

#include "interrupts.h"
#include "stm32l4xx.h"
#include "../lib/STM32L432KC.h"

static volatile int dt = 0;
static volatile int off   = 1;
static volatile int motorDirection = 0;
static volatile int32_t pulse_count = 0;
static volatile uint32_t elapsed_time_ms = 0;
static volatile float rps = 0.0;

void configureInterrupts(void) {
    EXTI->IMR1 |= (1 << gpioPinOffset(ENCODER_A_PIN));  // configure mask bit
    EXTI->RTSR1 |= (1 << gpioPinOffset(ENCODER_A_PIN)); // enable rising edge trigger
    EXTI->FTSR1 |= (1 << gpioPinOffset(ENCODER_A_PIN)); // enable falling edge trigger

    EXTI->IMR1 |= (1 << gpioPinOffset(ENCODER_B_PIN));  // configure mask bit
    EXTI->RTSR1 |= (1 << gpioPinOffset(ENCODER_B_PIN)); // enable rising edge trigger
    EXTI->FTSR1 |= (1 << gpioPinOffset(ENCODER_B_PIN)); // enable falling edge trigger

    // Enable EXTI interrupts in NVIC
    NVIC_EnableIRQ(EXTI9_5_IRQn);

    // Enable SysTick for 1ms interrupts
    SysTick_Config(SystemCoreClock / 1000);
}


// triggered by any edge on PA6 or PA8
// increments pulse count
void EXTI9_5_IRQHandler(void) {
    // clear interrupt
    EXTI->PR1 = EXTI->PR1;
    // read PA6, PA8
    uint32_t a = digitalRead(ENCODER_A_PIN);
    uint32_t b = digitalRead(ENCODER_B_PIN);

    uint8_t curr_AB = (a << 1) | b;

    // Static variable to hold previous AB state
    static uint8_t last_AB = 0;

    // Lookup table for quadrature decoding
    const int8_t lookup_table[16] = {0,  -1, 1, 0, 1, 0, 0,  -1,
                                   -1, 0,  0, 1, 0, 1, -1, 0};

    uint8_t index = (last_AB << 2) | curr_AB;
    int8_t change = lookup_table[index & 0x0F];

    pulse_count += change;
    last_AB = curr_AB;
}

// triggered every 1 ms
// prints rps every 0.25s
void SysTick_Handler(void) {
    elapsed_time_ms++;

    if (elapsed_time_ms >= 250) {
        rps = calculateRPS() * 4;
        printf("Revolutions per Second: %.2f\n", rps);
        elapsed_time_ms = 0;
        pulse_count = 0;
  }
}


int getdt(void) {
    __disable_irq();
    int d = dt;
    __enable_irq();
    return d;
}

void cleardt(void) {
    __disable_irq();
    dt = 0;
    __enable_irq();
}

int getOff(void) {
    return off;
}

float calculateRPS(void) {
    int curPulses = pulse_count;
    float r = (float)curPulses / (408*4);
    return r;
}