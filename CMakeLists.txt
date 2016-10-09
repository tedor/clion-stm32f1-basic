project(clion-stm32f1-basic)
cmake_minimum_required(VERSION 3.5.0)
ENABLE_LANGUAGE(ASM)

add_definitions(-DSTM32F103xB)
add_definitions(-DUSE_HAL_DRIVER)
add_definitions(-DHSE_VALUE=8000000)

file(GLOB_RECURSE USER_SOURCES "src/*.c")
file(GLOB_RECURSE SYSTEM_SOURCES "system/src/*.c")



add_library(CMSIS
        system/src/stm32f1xx/system_stm32f1xx.c
        system/src/stm32f1xx/startup_stm32f103xb.s)

include_directories(include)
include_directories(system/include/cmsis)
include_directories(system/include/FreeRTOS)
include_directories(system/include/stm32f1xx)
include_directories(system/include/stm32f1xx_hal)

add_executable(${PROJECT_NAME}.elf ${USER_SOURCES} ${SYSTEM_SOURCES} ${LINKER_SCRIPT})

target_link_libraries(${PROJECT_NAME}.elf CMSIS)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Map=${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.map")
set(HEX_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.bin)

set(CMIS)

add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE} \nBuilding ${BIN_FILE}")