#include <stdint.h>

#include "stm32f4xx_hal.h"
#include "stm32f4xx_hal_gpio.h"
#include "stm32f4xx_hal_rcc.h"

#define LED_R GPIO_PIN_3
#define LED_G GPIO_PIN_4
#define LED_B GPIO_PIN_1

void clock_init(void)
{
  // TODO: set the clocks as desired
	
  SystemCoreClockUpdate(); // must be called every time core clock is changed
}

void gpio_init(void)
{
  // Clock must be enabled first, then we can set the registers
  __HAL_RCC_GPIOE_CLK_ENABLE();
  
  // set LED pins as outputs
  GPIO_InitTypeDef pinInit;
  pinInit.Pin = LED_R | LED_G | LED_B;
  pinInit.Mode = GPIO_MODE_OUTPUT_PP;
  pinInit.Pull = GPIO_NOPULL;
  pinInit.Speed = GPIO_SPEED_FREQ_LOW;
  
  HAL_GPIO_Init(GPIOE, &pinInit);
}

void main(void)
{
  // Hardware initialiazation
  clock_init();
  HAL_Init();
  gpio_init();

  // Initialization done. Enable IRQs
  __enable_irq();
  
  // Actual code
  HAL_GPIO_WritePin(GPIOE, LED_R | LED_G | LED_B, GPIO_PIN_SET);
  
  while(1)
  {
    HAL_GPIO_TogglePin(GPIOE, LED_R);
	HAL_Delay(500);
  }
}
