
add_executable(
    firmware
    AT25.c
    AT25.h
    code128.c
    code128.h
    # code128png.c
    epd27.c
    epd27.h
    EPD_Configuration.h
    FT6336.c
    FT6336.h
    main.c
    main.h
    NfcDecoder.c
    NfcDecoder.h
    psram.c
    psram.h
    qrcode.c
    qrcode.h
    sl_status.h
    tests.c
    tests.h
    utils.c
    utils.h
    iostubs.c
    # flashloader.c
    # startup_efm32pg23.c
)

target_link_libraries(
    firmware
    PRIVATE
    gecko-platform-emlib

)

add_library(firmwareconfigs INTERFACE)
target_include_directories(
  firmwareconfigs INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/config
)

target_link_libraries(gecko-platform-emlib PUBLIC gecko-device-efm32pg23 gecko-platform-emdrv firmwareconfigs)

target_link_options(firmware PRIVATE -T ${CMAKE_CURRENT_SOURCE_DIR}/efm32pg23.ld)



add_custom_target(
  firmware-bin
  ALL
  BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/firmware.bin
  DEPENDS firmware
  COMMENT "generate .bin file"
  COMMAND ${OBJCOPY_BIN} -O binary ${CMAKE_CURRENT_BINARY_DIR}/firmware
    ${CMAKE_CURRENT_BINARY_DIR}/firmware.bin
)

