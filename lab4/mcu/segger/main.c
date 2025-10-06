// main.c
// Play music from the starter file
// Diego Weiss
// dweissg@hmc.edu
// 9/30/25

#include "../lib/STM32L432KC_TIM.h"
#include "../lib/STM32L432KC_RCC.h"
#include "../lib/STM32L432KC_GPIO.h"
#include "../lib/STM32L432KC_FLASH.h"
#include <stdio.h>


#define SONG_PIN 6

// Pitch in Hz, duration in ms
const int notes[][2] = {
{659,	125},
{623,	125},
{659,	125},
{623,	125},
{659,	125},
{494,	125},
{587,	125},
{523,	125},
{440,	250},
{  0,	125},
{262,	125},
{330,	125},
{440,	125},
{494,	250},
{  0,	125},
{330,	125},
{416,	125},
{494,	125},
{523,	250},
{  0,	125},
{330,	125},
{659,	125},
{623,	125},
{659,	125},
{623,	125},
{659,	125},
{494,	125},
{587,	125},
{523,	125},
{440,	250},
{  0,	125},
{262,	125},
{330,	125},
{440,	125},
{494,	250},
{  0,	125},
{330,	125},
{523,	125},
{494,	125},
{440,	250},
{  0,	125},
{494,	125},
{523,	125},
{587,	125},
{659,	375},
{392,	125},
{699,	125},
{659,	125},
{587,	375},
{349,	125},
{659,	125},
{587,	125},
{523,	375},
{330,	125},
{587,	125},
{523,	125},
{494,	250},
{  0,	125},
{330,	125},
{659,	125},
{  0,	250},
{659,	125},
{1319,	125},
{  0,	250},
{623,	125},
{659,	125},
{  0,	250},
{623,	125},
{659,	125},
{623,	125},
{659,	125},
{623,	125},
{659,	125},
{494,	125},
{587,	125},
{523,	125},
{440,	250},
{  0,	125},
{262,	125},
{330,	125},
{440,	125},
{494,	250},
{  0,	125},
{330,	125},
{416,	125},
{494,	125},
{523,	250},
{  0,	125},
{330,	125},
{659,	125},
{623,	125},
{659,	125},
{623,	125},
{659,	125},
{494,	125},
{587,	125},
{523,	125},
{440,	250},
{  0,	125},
{262,	125},
{330,	125},
{440,	125},
{494,	250},
{  0,	125},
{330,	125},
{523,	125},
{494,	125},
{440,	500},
{  0,	0}};

// Hz, ms  (approx at 136 BPM)
const int notes2[][2] = {
  {494,3528},  // B4 sustained
  // measure 1–2 bass pattern
  {98,441},{123,441},{147,441},{98,441},
  {123,441},{147,441},{98,441},{123,441},
  // measure 3–4 Am / Bm chords
  {110,441},{131,441},{165,441},{110,441},
  {123,441},{147,441},{185,441},{123,441},
  // measure 5–6 Cm / Dm chords
  {131,441},{165,441},{196,441},{131,441},
  {147,441},{185,441},{220,441},{147,441},
  // measure 7–8 melody motion
  {523,220},{587,220},{659,220},{740,220},{784,441},
  {784,220},{740,220},{659,220},{587,220},{523,441},
  {0,0}
};


int main(void) {
    // Configure flash
    configureFlash();
    printf("Configured Flash \n");

    // Configure clock
    configureClock();

    // Enable clock peripherals

    RCC->APB2ENR |= (1 << 17); // TIM16
    RCC->APB2ENR |= (1 << 16); // TIM15
    RCC->AHB2ENR |= (1 << 0); // GPIOA

    // Setup clock for timers
    // Set APB1, APB2, AHB prescalers and clear all bits
    RCC->CFGR &= ~(0b111 << 8); // PPRE1, APB1
    RCC->CFGR &= ~(0b1111 << 4); // HPRE, AHB
    RCC->CFGR &= ~(0b111 << 11); // PPRE2, APB

    // Configure timers
    initTIM(TIM16, PRESCALER_SOUND); // frequency timer
    initTIM(TIM15, PRESCALER_DELAY); // delay timer

    // Configure pin for frequency output
    pinMode(GPIOA, SONG_PIN, GPIO_ALT);

    // Connect TIM16 to PA6 by ettng AF14
    GPIOA->AFRL &= ~(0b1111 << 4*SONG_PIN);
    GPIOA->AFRL |= (0b1110 << 4 * SONG_PIN);
    GPIOA->OSPEEDR |= (0b11 << 2*SONG_PIN);

    // loop to play song
    for (size_t i = 0; i < (sizeof(notes)/(2*sizeof(int))); ++i) {
        // get freq, rest
        float frequency = notes[i][0];
        float delay = notes[i][1];

        setFrequency(TIM16, frequency);
        setDelay(TIM15, delay);
    }

    for (size_t i = 0; i < (sizeof(notes2)/(2*sizeof(int))); ++i) {
      float frequency = notes2[i][0];
      float delay = notes[i][1];

      setFrequency(TIM16, frequency);
      setDelay(TIM15, delay);
    }

    for (;;);

    return 0;
}