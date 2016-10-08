#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "./import_cubemx_project.sh <import_project_path>"
    echo "Please enter import project path"
    exit
fi

PROJECT_DIR=`dirname $0`/..
TARGET_DIR=$1
LD_FILE_PATH=`find ${TARGET_DIR} -name "STM32F103C8Tx_FLASH.ld"`

echo "===================== Clean up ====================="
rm -v ${PROJECT_DIR}/include/stm32f1xx_hal_conf.h
rm -v ${PROJECT_DIR}/include/stm32f1xx_it.h

rm -v ${PROJECT_DIR}/src/stm32f1xx_hal_msp.c
rm -v ${PROJECT_DIR}/src/stm32f1xx_it.c

rm -v ${PROJECT_DIR}/system/include/stm32f1xx/*.h
rm -v ${PROJECT_DIR}/system/src/stm32f1xx/*

rm -v ${PROJECT_DIR}/system/src/stm32f1xx_hal/*.c
rm -v ${PROJECT_DIR}/system/include/stm32f1xx_hal/*.h
rm -v ${PROJECT_DIR}/system/include/stm32f1xx_hal/Legacy/*.h

rm -v ${PROJECT_DIR}/system/include/cmsis/*.h

echo "===================== Copy STM32 configs ====================="
cp -v ${TARGET_DIR}/Inc/stm32f1xx_hal_conf.h ${PROJECT_DIR}/include/
cp -v ${TARGET_DIR}/Inc/stm32f1xx_it.h ${PROJECT_DIR}/include/
cp -v "${LD_FILE_PATH}" ${PROJECT_DIR}/ldscripts/

cp -v ${TARGET_DIR}/Src/stm32f1xx_hal_msp.c ${PROJECT_DIR}/src/
cp -v ${TARGET_DIR}/Src/stm32f1xx_it.c ${PROJECT_DIR}/src/

cp -v ${TARGET_DIR}/Drivers/CMSIS/Device/ST/STM32F1xx/Include/*.h ${PROJECT_DIR}/system/include/stm32f1xx/
cp -v ${TARGET_DIR}/Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/system_stm32f1xx.c ${PROJECT_DIR}/system/src/stm32f1xx/
cp -v ${TARGET_DIR}/Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/gcc/startup_stm32f103xb.s ${PROJECT_DIR}/system/src/stm32f1xx/

echo "===================== Copy STM32 HAL driver ====================="
cp -v ${TARGET_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/*.c ${PROJECT_DIR}/system/src/stm32f1xx_hal/
rm ${PROJECT_DIR}/system/src/stm32f1xx_hal/stm32f1xx_hal_msp_template.c
cp -v ${TARGET_DIR}/Drivers/STM32F1xx_HAL_Driver/Inc/*.h ${PROJECT_DIR}/system/include/stm32f1xx_hal/
cp -v ${TARGET_DIR}/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy/*.h ${PROJECT_DIR}/system/include/stm32f1xx_hal/Legacy/
rm ${PROJECT_DIR}/system/include/stm32f1xx_hal/stm32f1xx_hal_conf_template.h

echo "===================== Copy STM32 CMSIS ====================="
cp -v ${TARGET_DIR}/Drivers/CMSIS/Include/*.h ${PROJECT_DIR}/system/include/cmsis


echo "===================== Copy CMSIS RTOS files ====================="
cp -v ${TARGET_DIR}/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS/cmsis_os.c ${PROJECT_DIR}/system/src/FreeRTOS/
cp -v ${TARGET_DIR}/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS/cmsis_os.h ${PROJECT_DIR}/system/include/FreeRTOS/