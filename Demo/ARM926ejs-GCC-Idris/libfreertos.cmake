#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

set(LIB FreeRTOS)
project(${LIB} C)

# GCC flags
set(CMAKE_C_FLAGS "\
    -c \
    -g \
    -O1 \
    -mcpu=arm926ej-s \
    -nostdlib \
    -Wall -Wextra -Werror \
    -fdata-sections -ffunction-sections"
)

# Set source directory variables
set(FREERTOS_DIR ${CMAKE_SOURCE_DIR}/Source)
set(FREERTOS_MEMMANG_DIR ${CMAKE_SOURCE_DIR}/Source/portable/MemMang)
set(FREERTOS_PORT_DIR ${CMAKE_SOURCE_DIR}/Source/portable/GCC/ARM926EJ-S)
set(DRIVERS_DIR ${CMAKE_SOURCE_DIR}/Source/portable/GCC/ARM926EJ-S/drivers)
set(APP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

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
)

# Create target
add_library(${LIB} EXCLUDE_FROM_ALL ${static})

# Header files
target_include_directories(${LIB} PUBLIC
    ${FREERTOS_DIR}/include
    ${FREERTOS_PORT_DIR}
    ${DRIVERS_DIR}/include
    ${APP_DIR}
)
