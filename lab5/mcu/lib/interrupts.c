#include "interrupts.h"


void configureInterrupts(int gpioPin) {
    EXTI->IMR1  |= (1 << gpioPinOffset(gpioPin));  // configure mask bit
    EXTI->RTSR1 |= (1 << gpioPinOffset(gpioPin)); // enable rising edge trigger
    EXTI->FTSR1 |= (1 << gpioPinOffset(gpioPin)); // enable falling edge trigger
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
        if(a == b) {
            delta = -COUNT_TIM->CNT;
        }

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
        if(a == b) {
            delta = -COUNT_TIM->CNT;
        }

        // reset the clock
        COUNT_TIM->CNT = 0;
    }
}
