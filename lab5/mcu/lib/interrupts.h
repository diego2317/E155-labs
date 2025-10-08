#ifndef INTERRUPTS_H
#define INTERRUPTS_H

#include "STM32L432KC_GPIO.h"
#include "../src/main.h"
#include <stm32l432xx.h>  // CMSIS device library include

void configureInterrupts(int gpioPin);

void EXTI9_5_IRQHandler(void);

#endif