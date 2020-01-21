#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

set(APP demo-AM3359_BeagleBone)
project(${APP} C)

# GCC flags
set(CMAKE_C_FLAGS "\
    -c \
    -mcpu=cortex-a8 \
    -nostdlib \
    -Wno-main-return-type \
    -Wall -Wextra \
    -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align \
    -Wsign-compare -Waggregate-return -Wstrict-prototypes \
    -Wmissing-prototypes -Wmissing-declarations -Wunused \
    -fomit-frame-pointer -fno-strict-aliasing -mno-unaligned-access"
)

# Set source directory variables
set(FREERTOS_DIR ${CMAKE_SOURCE_DIR}/Source)
set(FREERTOS_MEMMANG_DIR ${CMAKE_SOURCE_DIR}/Source/portable/MemMang)
set(FREERTOS_PORT_DIR ${CMAKE_SOURCE_DIR}/Source/portable/GCC/AM335_BeagleBone)
set(APP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# Use custom linking
set(LINKER_SCRIPT ${APP_DIR}/omap3-ram.ld)
set(CMAKE_EXE_LINKER_FLAGS
    "${CMAKE_EXE_LINKER_FLAGS} -T ${LINKER_SCRIPT} \
    -u __aeabi_uidiv -u __aeabi_idiv -u __aeabi_uidivmod \
    --gc-sections \
    -lc -lgcc -L ${LIBGCC} -L ${LIBC}")

# Files in project
file(GLOB static
    # FreeRTOS base
    ${FREERTOS_DIR}/queue.c
    ${FREERTOS_DIR}/list.c
    ${FREERTOS_DIR}/tasks.c
    # FreeRTOS heap
    ${FREERTOS_MEMMANG_DIR}/heap_2.c
    # FreeRTOS port
    ${FREERTOS_PORT_DIR}/port.c
    ${FREERTOS_PORT_DIR}/portISR.c
    # App
    ${APP_DIR}/boot.s
    ${APP_DIR}/main.c
    ${APP_DIR}/serial.c
    ${APP_DIR}/syscalls.c
    ${APP_DIR}/integer.c
    ${APP_DIR}/PollQ.c
    ${APP_DIR}/flop.c
    ${APP_DIR}/semtest.c
    ${APP_DIR}/dynamic.c
    ${APP_DIR}/BlockQ.c
)

# Tell CMake to treat this file as a C-file
set_property(SOURCE ${APP_DIR}/boot.s PROPERTY LANGUAGE C)

# Create target
add_executable(${APP} EXCLUDE_FROM_ALL ${static})
generate_binary(${APP})

# Header files
target_include_directories(${APP} PUBLIC
    ${FREERTOS_DIR}/include
    ${FREERTOS_PORT_DIR}
    ${APP_DIR}
)
