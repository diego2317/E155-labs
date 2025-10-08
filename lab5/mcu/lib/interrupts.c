#include "interrupts.h"
#include "stm32l4xx.h"
#include "../lib/STM32L432KC.h"

static volatile int delta = 0;
static volatile int off   = 1;

void configureInterrupts(void) {
    EXTI->IMR1 |= (1 << gpioPinOffset(ENCODER_A_PIN));  // configure mask bit
    EXTI->RTSR1 |= (1 << gpioPinOffset(ENCODER_A_PIN)); // enable rising edge trigger
    EXTI->FTSR1 |= (1 << gpioPinOffset(ENCODER_A_PIN)); // enable falling edge trigger

    EXTI->IMR1 |= (1 << gpioPinOffset(ENCODER_B_PIN));  // configure mask bit
    EXTI->RTSR1 |= (1 << gpioPinOffset(ENCODER_B_PIN)); // enable rising edge trigger
    EXTI->FTSR1 |= (1 << gpioPinOffset(ENCODER_B_PIN)); // enable falling edge trigger

    // Enable EXTI interrupts in NVIC
    NVIC_EnableIRQ(EXTI9_5_IRQn);
}

void EXTI9_5_IRQHandler(void) {
    // read PA6, PA7
    int a = digitalRead(ENCODER_A_PIN);
    int b = digitalRead(ENCODER_B_PIN);

    // if PA6 triggered the interrupt
    if (EXTI->PR1 & (1 << 6)) {
        // clear the interrupt
        EXTI->PR1 |= (1 << 6);
        off = 0;

        // if both signals are the same calculate delta
        if(a == b) delta = -COUNT_TIM->CNT;

        // reset the clock
        COUNT_TIM->CNT = 0;
    }

    // if PA7 triggered the interrupt
    if (EXTI->PR1 & (1 << 7)) {
        // clear the interrupt
        // clear the interrupt
        EXTI->PR1 |= (1 << 7);
        off = 0;

        // if both signals are the same calculate delta
        if(a == b) delta = -COUNT_TIM->CNT;

        // reset the clock
        COUNT_TIM->CNT = 0;
    }
}

int getDelta(void) {
    __disable_irq();
    int d = delta;
    __enable_irq();
    return d;
}

void clearDelta(void) {
    __disable_irq();
    delta = 0;
    __enable_irq();
}

int getOff(void) {
    return off;
}

float calculateRPMs(void) {
    static float rpms[4] = {0,0,0,0};
    float rpm;

    if (COUNT_TIM->CNT > 45000) {
            off = 1;
    }

    if (off) {
            rpm = 0.0;
    } else {
        float rps = 1 / (float)(408*d*4/100000.0);
        rpms[0] = rpms[1]; rpms[1] = rpms[2]; rpms[2] = rpms[3]; rpms[3] = rps * 60.0f;
        rpm = (rpms[0] + rpms[1] + rpms[2] + rpms[3]) * 0.25f;
    }

}