// STM32L432KC_FLASH.h
// Header for FLASH functions

#ifndef STM32_L4_FLASH_H
#define STM32_L4_FLASH_H

/**
* Struct for Flash registers
*/
typedef struct {
    volatile uint32_t FLASH_ACR;        // Offset: 0x00. Flash access control register
    volatile uint32_t FLASH_PDKEYR;     // Offset: 0x04. Flash power-down key register
    volatile uint32_t FLASH_KEYR;       // Offset: 0x08. Flash key register
    volatile uint32_t FLASH_OPTKEYR;    // Offset: 0x0C. Flash option key register
} FLASH;

#endif