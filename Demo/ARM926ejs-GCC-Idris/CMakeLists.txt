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
    -Wall -Wextra -Werror \
    -Wno-unused-label -Wno-unused-parameter -Wno-sign-compare"
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
    ${APP_DIR}/idr-main.c
    ${APP_DIR}/print.c
    ${APP_DIR}/receive.c
    ${APP_DIR}/nostdlib.c
)

# Tell CMake to treat this file as a C-file
set_property(SOURCE ${APP_DIR}/startup.s PROPERTY LANGUAGE C)

# Idris RTS

set(IDRIS_RTS ${CMAKE_SOURCE_DIR}/Libraries/idris-rts)
file(GLOB idris_rts_src
    ${IDRIS_RTS}/rts/idris_rts.c
    ${IDRIS_RTS}/rts/idris_heap.c
    ${IDRIS_RTS}/rts/idris_gc.c
    ${IDRIS_RTS}/rts/idris_gmp.c
    ${IDRIS_RTS}/rts/idris_bitstring.c
    ${IDRIS_RTS}/rts/idris_utf8.c
    ${IDRIS_RTS}/rts/mini-gmp.c
    ${IDRIS_RTS}/rts/bare-metal/idris_main.c
)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} \
    -W -Wall \
    -Wno-unused-parameter \
    -Wno-sign-compare \
    -Wno-unused-variable \
    -Wno-empty-body \
    -Wno-maybe-uninitialized \
    -Wno-unused-but-set-variable \
    -DIDRIS_TARGET_OS=\"\\\"bare-metal\\\"\" \
    -DBARE_METAL"
)

execute_process(
    COMMAND ${CMAKE_C_COMPILER} -dumpmachine
    OUTPUT_VARIABLE MACHINE
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DIDRIS_TARGET_TRIPLE=\"\\\"${MACHINE}\\\"\"")

# Create target
add_executable(${APP} EXCLUDE_FROM_ALL ${static} ${idris_rts_src})
generate_binary(${APP})

# Header files
target_include_directories(${APP} PUBLIC
    ${FREERTOS_DIR}/include
    ${FREERTOS_PORT_DIR}
    ${DRIVERS_DIR}/include
    ${APP_DIR}
    ${IDRIS_RTS}/rts
)
