#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

set(APP demo-ARM926ejs-Idris)
project(${APP} C)

include(libfreertos.cmake)

# Include Idris app transcompilation
add_subdirectory(Idris)

# GCC flags
set(CMAKE_C_FLAGS "\
    -c \
    -g \
    -O1 \
    -mcpu=arm926ej-s \
    -nostdlib \
    -Wall -Wextra -Werror \
    -Wno-implicit-function-declaration -Wno-unused-variable \
    -fdata-sections -ffunction-sections"
)

# Use FreeRTOS's malloc implementation
add_compile_definitions(malloc=pvPortMalloc)
add_compile_definitions(free=vPortFree)

# Add #define's for stdin, stdout and stderr for ${APP}-main.c to compile.
# These functions are not used and will be removed by the linker.
add_compile_definitions(stdin=0)
add_compile_definitions(stdout=1)
add_compile_definitions(stderr=2)

# Set source directory variables
set(FREERTOS_DIR ${CMAKE_SOURCE_DIR}/Source)
set(FREERTOS_MEMMANG_DIR ${CMAKE_SOURCE_DIR}/Source/portable/MemMang)
set(FREERTOS_PORT_DIR ${CMAKE_SOURCE_DIR}/Source/portable/GCC/ARM926EJ-S)
set(DRIVERS_DIR ${CMAKE_SOURCE_DIR}/Source/portable/GCC/ARM926EJ-S/drivers)
set(APP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# Use custom linking
set(LINKER_SCRIPT ${APP_DIR}/qemu.ld)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} \
    -Wl,-T,${LINKER_SCRIPT} \
    -Wl,--gc-sections \
    -nostdlib \
    -lgcc -L ${LIBGCC}"
)

# Files in project
file(GLOB static
    # FreeRTOS base
    ${FREERTOS_DIR}/queue.c
    ${FREERTOS_DIR}/list.c
    ${FREERTOS_DIR}/tasks.c
    # FreeRTOS heap
    ${FREERTOS_MEMMANG_DIR}/heap_4.c
    # FreeRTOS port
    ${FREERTOS_PORT_DIR}/port.c
    ${FREERTOS_PORT_DIR}/portISR.c
    # Versatilepb drivers
    ${DRIVERS_DIR}/timer.c
    ${DRIVERS_DIR}/interrupt.c
    ${DRIVERS_DIR}/uart.c
    # App base
    ${APP_DIR}/startup.s
    ${APP_DIR}/init.c
    ${APP_DIR}/print.c
    ${APP_DIR}/receive.c
    ${APP_DIR}/muslc_string.c
)

# Tell CMake to treat this file as a C-file
set_property(SOURCE ${APP_DIR}/startup.s PROPERTY LANGUAGE C)

set(CMAKE_C_FLAGS_IDRIS_MAIN "\
    -Wno-unused-label \
    -Wno-unused-parameter \
    -Wno-sign-compare \
    -Wno-implicit-function-declaration \
    -Wno-int-conversion"
)

set_source_files_properties(
    ${CMAKE_CURRENT_BINARY_DIR}/Idris/${APP}-main.c
    PROPERTIES COMPILE_FLAGS ${CMAKE_C_FLAGS_IDRIS_MAIN}
)

# Create target
add_executable(${APP} EXCLUDE_FROM_ALL
    ${static}
    ${idris_rts_src}
    ${CMAKE_CURRENT_BINARY_DIR}/Idris/${APP}-main.c
)
set_source_files_properties(
    ${CMAKE_CURRENT_BINARY_DIR}/Idris/${APP}-main.c
    PROPERTIES GENERATED TRUE
)
generate_binary(${APP})
create_qemu_target(versatilepb ${APP})

# Header files
target_include_directories(${APP} PUBLIC
    ${FREERTOS_DIR}/include
    ${FREERTOS_PORT_DIR}
    ${DRIVERS_DIR}/include
    ${APP_DIR}
    ${APP_DIR}/Idris
)
