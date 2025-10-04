// STM32L432KC_FLASH.c
// Source code for FLASH functions
// Author: Diego Weiss
// Date: 9/30/2025

#include "STM32L432KC_FLASH.h"

void configureFlash(void) {
  FLASH->ACR |= (0b100);     // Set to 4 waitstates
  FLASH->ACR |= (1 << 8);    // Turn on the ART
}