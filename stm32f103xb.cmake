INCLUDE(CMakeForceCompiler)

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
CMAKE_FORCE_C_COMPILER(arm-none-eabi-gcc GNU)
CMAKE_FORCE_CXX_COMPILER(arm-none-eabi-g++ GNU)
SET(CMAKE_ASM_COMPILER arm-none-eabi-gcc)

SET(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/ldscripts/STM32F103C8Tx_FLASH.ld)
SET(COMMON_FLAGS "-mcpu=cortex-m3 -mthumb -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize -Wall -g3 -ggdb")
SET(CMAKE_CXX_FLAGS "${COMMON_FLAGS} -std=c++11")
SET(CMAKE_C_FLAGS "${COMMON_FLAGS} -std=gnu99")
SET(CMAKE_ASM_FLAGS "-mthumb -mcpu=cortex-m3 -x assembler-with-cpp")
SET(CMAKE_EXE_LINKER_FLAGS "-Wl,-gc-sections -T ${LINKER_SCRIPT}")