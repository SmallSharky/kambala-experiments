#include "em_chip.h"
#include "em_cmu.h"
#include "em_gpio.h"
// #include "bsp.h"



void delay(uint32_t ticks) {
    for (uint32_t i = 0; i<ticks; ++i);
}

int main()
{
    constexpr GPIO_Port_TypeDef LED_PORT {gpioPortA};
    constexpr uint32_t LED_PIN{3};
    CHIP_Init();

    // Enable GPIO clock. Note this step is not required for EFR32xG21 devices
    CMU_ClockEnable(cmuClock_GPIO, true);

    // Configure Push Button 0 as input
    // GPIO_PinModeSet(LED_PORT, LED_PIN, gpioModeInput, 0);

    // Configure LED1 as a push pull for LED drive
    GPIO_PinModeSet(LED_PORT, LED_PIN, gpioModePushPull, 1);

    constexpr uint32_t delay_ticks{1000000};

    while (1)
    {
        GPIO_PinOutToggle(LED_PORT, LED_PIN);
        delay(delay_ticks);

    }
    return 0;
}