// STM32L432KC_FLASH.h
// Header for FLASH functions
// Author: Diego Weiss
// Date: 9/30/2025

#ifndef STM32_L4_FLASH_H
#define STM32_L4_FLASH_H

/**
* Struct for Flash registers
*/
typedef struct {
    volatile uint32_t ACR;        // Offset: 0x00. Flash access control register
    volatile uint32_t PDKEYR;     // Offset: 0x04. Flash power-down key register
    volatile uint32_t KEYR;       // Offset: 0x08. Flash key register
    volatile uint32_t OPTKEYR;    // Offset: 0x0C. Flash option key register
    volatile uint32_t SR;         // Offset: 0x10. Flash status register
    volatile uint32_t CR;         // Offset: 0x14. Flash control register
    volatile uint32_t ECCR;       // Offset: 0x18. Flash ECC register
    uint32_t RESERVED0;
    volatile uint32_t OPTR;       // Offset: 0x20. Flash option register
    volatile uint32_t PCROP1SR;   // Offset: 0x24. Flash PCROP Start address register
    volatile uint32_t PCROP1ER;   // Offset: 0x28. Flash PCROP End address register
    volatile uint32_t WRP1AR;     // Offset: 0x2C. Flash WRP area A address register
    volatile uint32_t WRP1BR;     // Offset: 0x30. Flash WRP area B address register
} FLASH;


// Function prototypes
void configureFlash(void);

#endif