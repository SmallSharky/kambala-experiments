
add_definitions(
    # -DEFM32PG23B200F512IM40
    # -Dflash_layout
    -DARM_MATH_CM4
    -Dflash_layout
    -DEFM32PG23B200F512IM40
    # -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard
    # -Dsram_layout
)

add_compile_options(
    # -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard
    -mfloat-abi=hard -mfpu=fpv4-sp-d16
    -mcpu=cortex-m33
    # -mthumb
    # -ffunction-sections -fno-exceptions -fno-rtti
    -mcmse
    # -nostartfiles
)
# set(LINKER_SCRIPT_PATH ${CMAKE_SOURCE_DIR}/STM32G431KBUX_FLASH.ld)

add_link_options(
    -mfloat-abi=hard -mfpu=fpv4-sp-d16
    -mcpu=cortex-m33
    -mcmse
    # -mthumb
    -Wl,--no-warn-rwx-segments
    # -nostdlib
    # -nostartfiles
    --specs=nano.specs
    # -u _printf_float
    # -u _kill_r
    --specs=nosys.specs
    # -lm
)
