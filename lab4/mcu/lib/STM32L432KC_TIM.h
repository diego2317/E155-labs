// STM32L432KC_RCC.h
// Header for RCC functions
// Author: Diego Weiss
// Date: 9/30/2025

#ifndef STM32L4_TIM15_H
#define STM32L4_TIM15_H

#include <stdint.h>
#include <math.h>
#include <stdio.h>

// Definitions

// Base addresses
#define TIM15_BASE (0x40014000UL) // base address of TIM15
#define TIM16_BASE (0x40014400UL) // base address of TIM16

// Clock configuration
#define CLOCK_SPEED 80 // Clock speed in MHz
#define PRESCALER_DELAY 1999 // The prescaler used for the delay timer
#define PRESCALER_SOUND 699 // The prescaler used for the sound frequency timer

// Timer configuration
#define DUTY_CYCLE 0.5 // duty cycle for the sounds we play

typedef struct {
    volatile uint32_t CR1;    // Offset: 0x00. TIM15 control register 1
    volatile uint32_t CR2;    // Offset: 0x04. TIM15 control register 2
    volatile uint32_t SMCR;   // Offset: 0x08. TIM15 slave mode control register
    volatile uint32_t DIER;   // Offset: 0x0C. TIM15 DMA/interrupt enable register
    volatile uint32_t SR;     // Offset: 0x10. TIM15 status register
    volatile uint32_t EGR;    // Offset: 0x14. TIM15 event generation register
    volatile uint32_t CCMR1;  // Offset: 0x18. TIM15 capture/compare mode register 1
    uint32_t RESERVED0;
    volatile uint32_t CCER;   // Offset: 0x20. TIM15 capture/compare enable register
    volatile uint32_t CNT;    // Offset: 0x24. TIM15 counter
    volatile uint32_t PSC;    // Offset: 0x28. TIM15 prescaler
    volatile uint32_t ARR;    // Offset: 0x2C. TIM15 auto-reload register
    volatile uint32_t RCR;    // Offset: 0x30. TIM15 repetition counter register
    volatile uint32_t CCR1;   // Offset: 0x34. TIM15 capture/compare register 1
    volatile uint32_t CCR2;   // Offset: 0x38. TIM15 capture/compare register 2
    uint32_t RESERVED1;
    uint32_t RESERVED2;
    volatile uint32_t BDTR;   // Offset: 0x44. TIM15 break and dead-time register
    volatile uint32_t DCR;    // Offset: 0x48. TIM15 DMA control register
    volatile uint32_t DMAR;   // Offset: 0x4C. TIM15 DMA address for full transfer
    volatile uint32_t OR1;    // Offset: 0x50. TIM15 option register 1
    uint32_t RESERVED3;
    uint32_t RESERVED4;
    uint32_t RESERVED5;
    volatile uint32_t OR2;    // Offset: 0x60. TIM15 option register 2
} TIM_TYPE;

#define TIM15 ((TIM_TYPE *) TIM15_BASE)
#define TIM16 ((TIM_TYPE *) TIM16_BASE)

// Function prototypes

void initTIM(TIM_TYPE * TIM, uint32_t prescaler);

void delayMillis(TIM_TYPE * TIM, uint32_t ms);

void setFrequency(TIM_TYPE * TIM, uint32_t freq);

#endif