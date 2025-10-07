// STM32L432KC_FLASH.h
// Header for FLASH functions
// Author: Diego Weiss
// Date: 9/30/2025

#ifndef STM32_L4_FLASH_H
#define STM32_L4_FLASH_H
#include <stdint.h>

#define FLASH_BASE (0x40022000UL) // base address of RCC

/**
* Struct for Flash registers
*/
typedef struct {
    volatile uint32_t ACR;        // Offset: 0x00. Flash access control register
    volatile uint32_t KEYR;       // Offset: 0x04. Flash key register
    volatile uint32_t OPTKEYR;    // Offset: 0x08. Flash option key register
    volatile uint32_t SR;         // Offset: 0x0C. Flash status register
    volatile uint32_t CR;         // Offset: 0x10. Flash control register
    volatile uint32_t OPTCR;      // Offset: 0x14. Flash option control register
    volatile uint32_t OPTCR1;     // Offset: 0x18. Flash option control register 1
} FLASH_TYPE;

#define FLASH ((FLASH_TYPE *) FLASH_BASE)

// Function prototypes
void configureFlash(void);

#endif