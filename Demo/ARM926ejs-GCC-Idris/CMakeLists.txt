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

# GCC flags
set(CMAKE_C_FLAGS "\
    -c \
    -mcpu=arm926ej-s \
    -nostdlib \
    -Wno-main-return-type \
    -Wall -Wextra -Werror"
)

# Set source directory variables
set(FREERTOS_DIR ${CMAKE_SOURCE_DIR}/Source)
set(FREERTOS_MEMMANG_DIR ${CMAKE_SOURCE_DIR}/Source/portable/MemMang)
set(FREERTOS_PORT_DIR ${CMAKE_SOURCE_DIR}/Source/portable/GCC/ARM926EJ-S)
set(DRIVERS_DIR ${CMAKE_SOURCE_DIR}/Source/portable/GCC/ARM926EJ-S/drivers)
set(APP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# Use custom linking
set(LINKER_SCRIPT ${APP_DIR}/qemu.ld)
set(CMAKE_EXE_LINKER_FLAGS
    "${CMAKE_EXE_LINKER_FLAGS} -T ${LINKER_SCRIPT}")

# Files in project
file(GLOB static
    # FreeRTOS base
    ${FREERTOS_DIR}/queue.c
    ${FREERTOS_DIR}/list.c
    ${FREERTOS_DIR}/tasks.c
    # FreeRTOS heap
    ${FREERTOS_MEMMANG_DIR}/heap_1.c
    # FreeRTOS port
    ${FREERTOS_PORT_DIR}/port.c
    ${FREERTOS_PORT_DIR}/portISR.c
    # Versatilepb drivers
    ${DRIVERS_DIR}/timer.c
    ${DRIVERS_DIR}/interrupt.c
    ${DRIVERS_DIR}/uart.c
    # App
    ${APP_DIR}/startup.s
    ${APP_DIR}/init.c
    ${APP_DIR}/main.c
    ${APP_DIR}/print.c
    ${APP_DIR}/receive.c
    ${APP_DIR}/nostdlib.c
)

# Tell CMake to treat this file as a C-file
set_property(SOURCE ${APP_DIR}/startup.s PROPERTY LANGUAGE C)

# Create target
add_executable(${APP} EXCLUDE_FROM_ALL ${static})
generate_binary(${APP})

# Header files
target_include_directories(${APP} PUBLIC
    ${FREERTOS_DIR}/include
    ${FREERTOS_PORT_DIR}
    ${DRIVERS_DIR}/include
    ${APP_DIR}
)
