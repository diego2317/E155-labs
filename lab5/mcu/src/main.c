#include "../lib/STM32L432KC.h"
#include <stm32l432xx.h>
#include <stdio.h>
#include "main.h"

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
    SYSCFG->EXTICR[2] |= _VAL2FLD(SYSCFG_EXTICR3_EXTI8, 0b000); // select PA8

    // Enable interrupts globally
    __enable_irq();

    // Configure interrupts for both edges
    configureInterrupts();
    float rpm = 0.0; 

    // Update every 0.25s
    while(1) {
        
        rpm = calculateRPMs();

        // print rps in debug mode using printf
        printf("Revolutions per Second: %.2f\n", rpm);

        delay_millis(DELAY_TIM, 250);
    }
    return 0;
}