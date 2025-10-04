// STM32L432KC_RCC.h
// Header for RCC functions
// Author: Diego Weiss
// Date: 9/30/2025

#ifndef STM32_L4_RCC_H
#define STM32_L4_RCC_H

#include <stdint.h>

// Base addresses
#define RCC_BASE (0x40021000UL) // base address of RCC

// PLL
#define PLLSRC_HSI 0
#define PLLSRC_HSE 1

// Clock configuration
#define SW_HSI  0
#define SW_HSE  1
#define SW_PLL  2

/**
* Struct for Reset and Clock Control registers
*/
typedef struct {
    volatile uint32_t CR;           // Offset: 0x00. Clock control register
    volatile uint32_t ICSCR;        // Offset: 0x04. Internal clock sources calibration register
    volatile uint32_t CFGR;         // Offset: 0x08. Clock configuration register
    volatile uint32_t PLLCFGR;      // Offset: 0x0C. PLL configuration register
    volatile uint32_t PLLSAI1CFGR;  // Offset: 0x10. PLLSAI1 configuration register
    uint32_t RESERVED0;
    volatile uint32_t CIER;         // Offset: 0x18. Clock interrupt enable register
    volatile uint32_t CIFR;         // Offset: 0x1C. Clock interrupt flag register
    volatile uint32_t CICR;         // Offset: 0x20. Clock interrupt clear register
    uint32_t RESERVED1;
    volatile uint32_t AHB1RSTR;     // Offset: 0x28. AHB1 peripheral reset register
    volatile uint32_t AHB2RSTR;     // Offset: 0x2C. AHB2 peripheral reset register
    volatile uint32_t AHB3RSTR;     // Offset: 0x30. AHB3 peripheral reset register
    uint32_t RESERVED2;
    volatile uint32_t APB1RSTR1;    // Offset: 0x38. APB1 peripheral reset register 1
    volatile uint32_t APB1RSTR2;    // Offset: 0x3C. APB1 peripheral reset register 2
    volatile uint32_t APB2RSTR;     // Offset: 0x40. APB2 peripheral reset register
    uint32_t RESERVED3;
    volatile uint32_t AHB1ENR;      // Offset: 0x48. AHB1 peripheral clock enable register
    volatile uint32_t AHB2ENR;      // Offset: 0x4C. AHB2 peripheral clock enable register
    volatile uint32_t AHB3ENR;      // Offset: 0x50. AHB3 peripheral clock enable register
    uint32_t RESERVED4;
    volatile uint32_t APB1ENR1;     // Offset: 0x58. APB1 peripheral clock enable register 1
    volatile uint32_t APB1ENR2;     // Offset: 0x5C. APB1 peripheral clock enable register 2
    volatile uint32_t APB2ENR;      // Offset: 0x60. APB2 peripheral clock ebable register
    uint32_t RESERVED5;
    volatile uint32_t AHB1SMENR;    // Offset: 0x68. AHB1 peripheral clocks enable in Sleep and Stop modes register
    volatile uint32_t AHB2SMENR;    // Offset: 0x6C. AHB2 peripheral clocks enable in Sleep and Stop modes register
    volatile uint32_t AHB3SMENR;    // Offset: 0x70. AHB3 peripheral clocks enable in Sleep and Stop modes register
    uint32_t RESERVED6;
    volatile uint32_t APB1SMENR1;   // Offset: 0x78. APB1 peripheral clocks enable in Sleep and Stop modes register 1
    volatile uint32_t APB1SMENR2;   // Offset: 0x7C. APB1 peripheral clocks enable in Sleep and Stop modes register 2
    volatile uint32_t APB2SMENR;    // Offset: 0x80. APB2 peripheral clocks enable in Sleep and Stop modes register
    uint32_t RESERVED7;
    volatile uint32_t CCIPR;        // Offset: 0x88. Peripherals independent clock configuration register
    uint32_t RESERVED8;
    volatile uint32_t BDCR;         // Offset: 0x90. Backup domain control register
    volatile uint32_t CSR;          // Offset: 0x94. Control/status register
    volatile uint32_t CRRCR;        // Offset: 0x98. Clock recovery RC register
    volatile uint32_t CCIPR2;       // Offset: 0x9C. Peripherals independent clock configuration register
} RCC_TYPE;

#define RCC ((RCC_TYPE *) RCC_BASE)

// Function Prototypes
void configurePLL(void);
void configureClock(void);

#endif