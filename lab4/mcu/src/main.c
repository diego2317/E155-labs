// main.c
// Play music from the starter file
// Diego Weiss
// dweissg@hmc.edu
// 9/30/25

#include "../lib/STM32L432KC_TIM.h"
#include "../lib/STM32L432KC_RCC.h"
#include "../lib/STM32L432KC_GPIO.h"
#include "../lib/STM32L432KC_FLASH.h"


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


const int hcb[][2] = {
{392, 500},   // G
{349, 500},   // F
{330, 1000},  // E (hold)
{392, 500},   // G
{349, 500},   // F
{330, 1000},  // E (hold)
{330, 250}, {330, 250}, {330, 250}, // E E E
{349, 250}, {349, 250}, {349, 250}, // F F F
{392, 500}, {349, 500}, {330, 1000} // G F E
};


int main(void) {
	// Configure flash
    configureFlash();

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

    // Connect TIM16 to PA6 by setting AF14
    GPIOA->AFRL &= ~(0b1111 << 4*SONG_PIN);
    GPIOA->AFRL |= (0b1110 << 4 * SONG_PIN);
    GPIOA->OSPEEDR |= (0b11 << 2*SONG_PIN);

    // loop to play song
    for (size_t i = 0; i < (sizeof(notes)/(2*sizeof(size_t))); ++i) {
        // get freq, rest
        float frequency = notes[i][0];
        float delay = notes[i][1];

        setFrequency(TIM16, frequency);
        setDelay(TIM15, delay);
    }

    for (size_t i = 0; i < (sizeof(hcb)/(2*sizeof(size_t))); ++i) {
        // get freq, rest
        float frequency = hcb[i][0];
        float delay = hcb[i][1];

        setFrequency(TIM16, frequency);
        setDelay(TIM15, delay);
    }

    for (;;);

    return 0;
}