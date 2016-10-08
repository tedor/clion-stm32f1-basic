# clion-stm32-basic
Bootstrap with FreeRTOS and STM32 HAL libraries for STM32F103C8T6 microcontroler.
This example was created for STM32F103 microcontroller version from [eBay](http://www.ebay.com/itm/STM32F103C8T6-ARM-STM32-Minimum-System-Development-Board-Module-For-Arduino-/311156408508?hash=item48725e00bc:g:ngMAAOSwygJXhGtV)

Also in bin directory existed 2 scripts:

 - import_cubemx_project.sh - import source files from STM32 CubeMX tool
 - install_freertos.sh - install fresh FreeRTOS
 
## Clion configuration
Open "Preferences -> Build, Execution, Deployment -> CMake" and set next fields:

 - CMake options: `-DCMAKE_TOOLCHAIN_FILE=STM32F103xb.cmake`
 - Build output path: `build`
 
## Import STM32 CubeMX sources
 1. Open STM32 CubeMX tool
 2. Add and configure your STM32F103 microcontroller and enable "FreeRTOS" checkbox
 3. Go to "Project -> settings" and choose "Toolchain / IDE" -> "SW4STM32", and copy somewhere "Toolchain Location Folder"
 4. Click "Project -> Generate code"
 5. Run command: `./bin/import_cubemx_project.sh <Toolchain Location Folder>`
 6. Done

## Install FreeRTOS new version
 1. Download zip file from [SourceForge](https://sourceforge.net/projects/freertos/files/FreeRTOS/)
 2. Run command: `./bin/install_freertos.sh FreeRTOSv9.0.0.zip heap_4.c`
 3. Done
