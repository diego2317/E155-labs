// STM32L432KC_SPI.c
// Diego Weiss
// dweiss@hmc.edu
// 10/15/25
// Source code for SPI functions

#include "STM32L432KC.h"

void initSPI(int br, int cpol, int cpha) {
    // Configure GPIO for SDO, SDI, SCK
    RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;
    pinMode(SPI_SDI, GPIO_ALT);
    pinMode(SPI_SDO, GPIO_ALT);
    pinMode(SPI_CS, GPIO_OUTPUT);
    digitalWrite(SPI_CS, PIO_LOW);
    pinMode(SPI_SCK, GPIO_ALT);
    
    GPIOB->OSPEEDR |= GPIO_OSPEEDR_OSPEED3; // high speed clock output

    // Tell the MCU which alternate function to use
    GPIOB->AFR[0] |= _VAL2FLD(GPIO_AFRL_AFSEL3, 5);
    GPIOB->AFR[0] |= _VAL2FLD(GPIO_AFRL_AFSEL4, 5);
    GPIOB->AFR[0] |= _VAL2FLD(GPIO_AFRL_AFSEL5, 5);

    // Write to SPI_CR1 register
    SPI1->CR1 = 0; // clear
    SPI1->CR1 |= _VAL2FLD(SPI_CR1_BR, br); // set baud rate
    SPI1->CR1 |= (SPI_CR1_MSTR); // configure as master
    SPI1->CR1 |= _VAL2FLD(SPI_CR1_CPOL, cpol); // set clock polarity
    SPI1->CR1 |= _VAL2FLD(SPI_CR1_CPHA, cpha); // set clock phase

    // Write to SPI_CR2 register
    SPI1->CR2 |= _VAL2FLD(SPI_CR2_DS, 0b0111); // configure data length for transfer as 8 bit
    SPI1->CR2 |= (SPI_CR2_FRXTH | SPI_CR2_SSOE); //set FIFO reception and SS output

    // Enable SPI
    SPI1->CR1 |= (SPI_CR1_SPE); 
}

char spiSendReceive(char send) {
    // Wait until TX buffer is empty
    while (!(SPI1->SR & SPI_SR_TXE)); // do nothing
    // Write data to TX buffer
    *(volatile char *) (&SPI1->DR) = send; // cast to volatile, we don't want the compiler optimizing
    // Wait until the RX buffer is not empty
    while (!(SPI1->SR & SPI_SR_RXNE)); // do nothing
    // Read data from buffer
    volatile char received = (volatile char) SPI1->DR; // cast to volatile, we don't want the compiler optimizing
    return received;
}