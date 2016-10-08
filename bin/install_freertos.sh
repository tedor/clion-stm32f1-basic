#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "./install_freertos.sh </path_to/FreeRTOSvX.X.X.zip> <heap_4.c>"
    echo "Please enter FreeRTOS zip file"
    exit
fi

if [ -z "$2" ]; then
    echo "./install_freertos.sh <FreeRTOSvX.X.X.zip> <heap_4.c>"
    echo "Please enter memory heap file"
    exit
fi

PROJECT_DIR=`dirname $0`/..
FREE_RTOS_ZIP=$1
MEMORY_HEAP_FILE=$2

echo "===================== Unpack archive ====================="
tar -xvzf ${FREE_RTOS_ZIP} -C /tmp/

FREE_RTOS_DIR=`find /tmp/ -name "FreeRTOS*" -type d -maxdepth 1 -print`

echo "===================== Clean up ====================="
rm -v ${PROJECT_DIR}/system/include/FreeRTOS/*.h
rm -v ${PROJECT_DIR}/system/src/FreeRTOS/*.c

echo "===================== Copy *.h files ====================="
cp -v ${FREE_RTOS_DIR}/FreeRTOS/Source/include/*.h ${PROJECT_DIR}/system/include/FreeRTOS/
cp -v ${FREE_RTOS_DIR}/FreeRTOS/Source/portable/GCC/ARM_CM3/portmacro.h ${PROJECT_DIR}/system/include/FreeRTOS/

echo "===================== Copy *.c files ====================="
cp -v ${FREE_RTOS_DIR}/FreeRTOS/Source/*.c ${PROJECT_DIR}/system/src/FreeRTOS/
cp -v ${FREE_RTOS_DIR}/FreeRTOS/Source/portable/GCC/ARM_CM3/port.c ${PROJECT_DIR}/system/src/FreeRTOS/

echo "===================== Copy memory heap file ====================="
cp -v ${FREE_RTOS_DIR}/FreeRTOS/Source/portable/MemMang/${MEMORY_HEAP_FILE} ${PROJECT_DIR}/system/src/FreeRTOS/

echo "===================== Remove unpacked files ====================="
rm -r ${FREE_RTOS_DIR}
echo "${FREE_RTOS_DIR} folder is removed"