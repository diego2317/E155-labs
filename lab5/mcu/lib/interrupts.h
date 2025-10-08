#ifndef INTERRUPTS_H
#define INTERRUPTS_H

#include "STM32L432KC_GPIO.h"
#include <stm32l432xx.h>  // CMSIS device library include

#define ENCODER_A_PIN PA6
#define ENCODER_B_PIN PA8

#define DELAY_TIM TIM2
#define COUNT_TIM TIM6

void configureInterrupts(void);

void EXTI9_5_IRQHandler(void);

int getDelta(void);

int getOff(void);

float calculateRPMs(void);

#endif