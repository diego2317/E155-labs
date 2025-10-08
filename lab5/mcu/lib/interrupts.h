// interrupts.h
// Header for interrupt functions
// Author: Diego Weiss
// Email: dweiss@hmc.edu
// 10/8/2025

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

void SysTick_Handler(void);

int getDelta(void);

int getOff(void);

float calculateRPS(void);

#endif