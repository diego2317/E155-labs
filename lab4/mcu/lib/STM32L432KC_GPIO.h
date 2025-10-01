// STM32L432KC_FLASH.h
// Header for FLASH functions
// Author: Diego Weiss
// Date: 9/30/2025

#ifndef STM32_L4_GPIO_H
#define STM32_L4_GPIO_H

// Pins in use
#define SONG_PIN    6

// Base addresses for GPIO ports
#define GPIOB_BASE  (0x48000400UL)
#define GPIOA_BASE  (0x48000000UL)

// Arbitrary GPIO functions for pinMode()
#define GPIO_INPUT  0
#define GPIO_OUTPUT 1
#define GPIO_ALT    2
#define GPIO_ANALOG 3

/**
* Struct for GPIO registers
*/
typedef struct {
    volatile uint32_t MODER;      // Offset: 0x00. GPIO Port mode register
    volatile uint32_t OTYPER;     // Offset: 0x04. GPIO port output type register
    volatile uint32_t OSPEEDR;    // Offset: 0x08. GPIO port output speed register
    volatile uint32_t PUPDR;      // Offset: 0x0C. GPIO port pull-up/pull-down register
    volatile uint32_t IDR;        // Offset: 0x10. GPIO port input data register
    volatile uint32_t ODR;        // Offset: 0x14. GPIO port output data register
    volatile uint32_t BSRR;       // Offset: 0x18. GPIO port bit set/reset register
    volatile uint32_t LCKR;       // Offset: 0x1C. GPIO port configuration lock register
    volatile uint32_t AFRL;       // Offset: 0x20. GPIO alternate function low register
    volatile uint32_t AFRH;       // Offset: 0x24. GPIO alternate function high register
    volatile uint32_t BRR;        // Offset: 0x28. GPIO port bit reset register
} GPIO_PIN;

#define GPIOA ((GPIO_PIN *) GPIOA_BASE)
#define GPIOB ((GPIO_PIN *) GPIOB_BASE)


// Function prototypes
void pinMode(GPIO_PIN * GPIO, int pin, int function);

int digitalRead(GPIO_PIN * GPIO, int pin);

void digitalWrite(GPIO_PIN * GPIO, int pin, int val);

void togglePin(GPIO_PIN * GPIO, int pin);

#endif