/**
 * Interrupt functions definition. See startup.c for a list of all the available
 * ISRs
 */
#include "stm32f4xx.h"
#include "stm32f4xx_hal.h"

void systick_handler()
{
	HAL_IncTick();
}
