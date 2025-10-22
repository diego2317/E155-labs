// DS1722.h
// Diego Weiss
// dweiss@hmc.edu
// 10/15/25
// Header file for DS1722 functions

#ifndef DS1722_H
#define DS1722_H

#include <stdint.h>
// Initializes the DS1722
void initDS1722(void);

// Changes the resolution of the DS1722
void changeResolution(uint8_t bits);

// Returns the temperature from the DS1722 in Celsius
float readTemperature(void);


#endif