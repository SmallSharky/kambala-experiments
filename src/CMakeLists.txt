
add_executable(
    hardtesting
    app-hardtesting/AT25.c
    app-hardtesting/AT25.h
    app-hardtesting/code128.c
    app-hardtesting/code128.h
    # app-hardtesting/code128png.c
    app-hardtesting/epd27.c
    app-hardtesting/epd27.h
    app-hardtesting/EPD_Configuration.h
    app-hardtesting/FT6336.c
    app-hardtesting/FT6336.h
    app-hardtesting/main.c
    app-hardtesting/main.h
    app-hardtesting/NfcDecoder.c
    app-hardtesting/NfcDecoder.h
    app-hardtesting/psram.c
    app-hardtesting/psram.h
    app-hardtesting/qrcode.c
    app-hardtesting/qrcode.h
    app-hardtesting/sl_status.h
    app-hardtesting/tests.c
    app-hardtesting/tests.h
    app-hardtesting/utils.c
    app-hardtesting/utils.h
    # app-hardtesting/iostubs.c
    # app-hardtesting/flashloader.c
    # app-hardtesting/startup_efm32pg23.c
)


target_include_directories(hardtesting PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
add_library(firmwareconfigs INTERFACE)
target_include_directories(firmwareconfigs INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/config)

target_link_libraries(
  gecko-platform-emlib
  PUBLIC
  gecko-device-efm32pg23
  gecko-platform-emdrv
  firmwareconfigs
)

target_link_options(hardtesting PRIVATE -T ${CMAKE_CURRENT_SOURCE_DIR}/efm32pg23.ld)

target_link_libraries(
  hardtesting
  PRIVATE
  gecko-platform-emlib
  gecko-platform-emdrv
)

add_custom_command(
    TARGET hardtesting
    POST_BUILD
    BYPRODUCTS hardtesting.bin
    DEPENDS hardtesting
    COMMAND ${OBJCOPY_BIN} -O binary "$<TARGET_FILE:hardtesting>" "$<TARGET_FILE:hardtesting>.bin"
    COMMAND arm-none-eabi-size hardtesting
    VERBATIM
)

add_custom_target(
    flash-hardtesting
    DEPENDS hardtesting.bin
    COMMAND pilkki write -i hardtesting.bin
    COMMAND pilkki reset
)


add_executable (
  ledblink
  app-ledblink/main.cpp
)

target_link_options(ledblink PRIVATE -T ${CMAKE_CURRENT_SOURCE_DIR}/efm32pg23.ld)
target_link_libraries(gecko-platform-emlib PUBLIC gecko-device-efm32pg23)
target_link_libraries(ledblink PRIVATE gecko-platform-emlib gecko-platform-emdrv)


add_custom_command(
    TARGET ledblink
    POST_BUILD
    BYPRODUCTS ledblink.bin
    DEPENDS ledblink
    COMMAND ${OBJCOPY_BIN} -O binary "$<TARGET_FILE:ledblink>" "$<TARGET_FILE:ledblink>.bin"
    COMMAND arm-none-eabi-size ledblink
    VERBATIM
)

add_custom_target(
    flash-ledblink
    DEPENDS ledblink.bin
    COMMAND pilkki write -i ledblink.bin
    COMMAND pilkki reset
)