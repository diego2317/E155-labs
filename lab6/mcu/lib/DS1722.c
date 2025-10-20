// DS1722.c
// Diego Weiss
// dweiss@hmc.edu
// 10/15/25
// Source code for DS1722 functions


#include "DS1722.h"
#include "STM32L432KC.h"

void initDS1722(void) {
    // set CS pin high
    digitalWrite(SPI_CS, PIO_HIGH);

    // Setup configuration register
    spiSendReceive(0x80); // Send write address
    spiSendReceive(0xEE); // Send data to write, autoconfigure to 12-bit resolution

    // Set CS pin LOW
    digitalWrite(SPI_CS, PIO_LOW);
}

void changeResolution(uint8_t bits) {
    digitalWrite(SPI_CS, PIO_HIGH); // CS pin high
    switch (bits) {
        case 8:
            spiSendReceive(0xE0); //0b11100000
            delay_millis(TIM15, 75);
        break;
        case 9:
            spiSendReceive(0xE2); //0b11100010
            delay_millis(TIM15, 150);
        break;
        case 10:
            spiSendReceive(0xE4); //0b11100100
            delay_millis(TIM15, 300);
        break;
        case 11:
            spiSendReceive(0xE6); //0b11100110
            delay_millis(TIM15, 600);
        break;
        case 12:
            spiSendReceive(0xE8); //0b11101110
            delay_millis(TIM15, 1200);
        break;
        default:
            // do nothing
    }
    digitalWrite(SPI_CS, PIO_LOW); // CS pin low
}

float readTemperature(void) {
    digitalWrite(SPI_CS, PIO_HIGH); // CS pin high

    int8_t msb = 0;
    int8_t lsb = 0;
    spiSendReceive(0x02); // tell sensor we want to read MSB register
    msb = spiSendReceive(0x44); // read msb, 0b01000100
    digitalWrite(SPI_CS, PIO_LOW);
    digitalWrite(SPI_CS, PIO_HIGH);
    spiSendReceive(0x01); // tell sensor we want to read LSB register
    lsb = spiSendReceive(0x45); // read lsb, 0b01000101

    digitalWrite(SPI_CS, PIO_LOW); // CS pin low

    float temp = msb + (lsb / 256.0);

    return temp;
}