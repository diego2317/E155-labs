// STM32L432KC_SPI.c
// Diego Weiss
// dweiss@hmc.edu
// 10/15/25
// Source code for SPI functions

#include "STM32L432KC.h"

void initSPI(int br, int cpol, int cpha) {
    // Configure GPIO for SDO, SDI, SCK
    pinMode(SPI_SDI, GPIO_ALT);
    pinMode(SPI_SDO, GPIO_ALT);
    pinMode(SPI_SCK, GPIO_OUTPUT);
    // Write to SPI_CR1 register
    // configure SCK using br[2:0]
    SPI1->CR1 = 0; // clear
    SPI1->CR1 |= _VAL2FLD(SPI_CR1_BR, br); // set baud rate
    SPI1->CR1 |= _VAL2FLD(SPI_CR1_CPOL, cpol); // set clock polarity
    SPI1->CR1 |= _VAL2FLD(SPI_CR1_CPHA, cpha); // set clock phase
    SPI1->CR1 |= (SPI_CR1_MSTR);
    SPI1->CR2 |= _VAL2FLD(SPI_CR2_DS, 0b0111);
    SPI1->CR2 |= (SPI_CR2_FRXTH | SPI_CR2_SSOE);

    SPI1->CR1 |= (SPI_CR1_SE); // enable spi
}

char spiSendReceive(char send) {
    // Wait until TX buffer is empty
    while (!(SPI1->SR & SPI_SR_TXE)); // do nothing
    // Write data to TX buffer
    *(volatile char) (SPI1->DR) = send;
    // Wait until the RX buffer is not empty
    while (!(SPI1->SR & SPI_SR_RXNE)); // do nothing
    // Read data from buffer
    volatile char received = (volatile char) SPI1->DR;
    return received;
}