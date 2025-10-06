// STM32L432KC_FLASH.c
// Source code for FLASH functions
// Author: Diego Weiss
// Date: 9/30/2025

#include "STM32L432KC_FLASH.h"
#include <stdio.h>

void configureFlash(void) {
  FLASH->ACR |= (0b100);     // Set to 4 waitstates
  printf("Got past step 1 of configure flash \n");
  
  FLASH->ACR |= (1 << 8);    // Turn on the ART
  printf("Got past step 2 of configure flash \n");
}