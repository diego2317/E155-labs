#ifndef INTERRUPTS_H
#define INTERRUPTS_H

#include "STM32L432KC_GPIO.h"
#include "../src/main.h"
#include <stm32l432xx.h>  // CMSIS device library include

void configureInterrupts(void);

void EXTI9_5_IRQHandler(void);

int getDelta(void);

int getOff(void);

float calculateRPMs(void);

#endif