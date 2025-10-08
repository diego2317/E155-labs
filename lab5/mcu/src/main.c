#include "../lib/STM32L432KC.h"
#include <stm32l432xx.h>
#include <stdio.h>




int delta = 0;
int off = 1;

int main(void) {
    // Configure encoders as inputs
    gpioEnable(GPIO_PORT_A);
    gpioEnable(GPIO_PORT_B);
    pinMode(ENCODER_A_PIN, GPIO_INPUT);
    pinMode(ENCODER_B_PIN, GPIO_INPUT);

    // Initialize timers
    RCC->APB1ENR1 |= RCC_APB1ENR1_TIM2EN; // timer 2
    RCC->APB1ENR1 |= RCC_APB1ENR1_TIM6EN;  // timer 6
    initTIM(DELAY_TIM);
    initFastTIM(COUNT_TIM);


    // Enable SYSCFG clock domain in RCC
    RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN;

    // Configure EXTICR for encoder interrupts
    SYSCFG->EXTICR[1] |= _VAL2FLD(SYSCFG_EXTICR2_EXTI6, 0b000); // select PA6
    SYSCFG->EXTICR[2] |= _VAL2FLD(SYSCFG_EXTICR2_EXTI7, 0b000); // select PA7

    // Enable interrupts globally
    __enable_irq();

    // Configure interrupts for both edges
    EXTI->IMR1 |= (1 << gpioPinOffset(ENCODER_A_PIN));  // configure mask bit
    EXTI->RTSR1 |= (1 << gpioPinOffset(ENCODER_A_PIN)); // enable rising edge trigger
    EXTI->FTSR1 |= (1 << gpioPinOffset(ENCODER_A_PIN)); // enable falling edge trigger
    //configureInterrupts(ENCODER_A_PIN)

    EXTI->IMR1 |= (1 << gpioPinOffset(ENCODER_B_PIN));  // configure mask bit
    EXTI->RTSR1 |= (1 << gpioPinOffset(ENCODER_B_PIN)); // enable rising edge trigger
    EXTI->FTSR1 |= (1 << gpioPinOffset(ENCODER_B_PIN)); // enable falling edge trigger
    //configureInterrupts(ENCODER_B_PIN)


    // Enable EXTI Interrupts in NVIC
    NVIC_EnableIRQ(EXTI9_5_IRQn);

    uint32_t prescaler = 0;
    uint32_t clock_freq = 0;
    float pulse_length = 0.0;
    float time_per_pulse = 0.0;
    float average_speed = 0.0;

    float rpms[4] = {0.0, 0.0, 0.0, 0.0};
    float rpm = 0.0; 

    // Update every 0.25s
    while(1) {
        
        if (COUNT_TIM->CNT > 45000) {
            off = 1;
        }

        if (off) {
            rpm = 0.0;
        } else {
            if (rpm == 0.0) {
                rpms[0] = 1 / (float)(408*delta*4/100000.0);
                rpms[1] = rpms[0];
                rpms[2] = rpms[0];
                rpms[3] = rpms[0];
            } else {
                rpms[0] = rpms[1];
                rpms[1] = rpms[2];
                rpms[2] = rpms[3];
                rpms[3] = 1 / (float)(408*delta*4/100000.0);
            }
        }

        // print rps in debug mode using printf
        printf("Revolutions per Second: %.2f\n", rpm);

        delay_millis(DELAY_TIM, 250);
    }
    return 0;
}