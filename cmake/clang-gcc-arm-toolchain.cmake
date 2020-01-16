#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)
set(ClangGccToolchain ON)

if("${CROSS_COMPILER_PREFIX}" STREQUAL "")
    set(CROSS_COMPILER_PREFIX "arm-none-eabi" CACHE INTERNAL "")
    message(STATUS "Using default value for CROSS_COMPILER_PREFIX (${CROSS_COMPILER_PREFIX})")
endif()

set(CMAKE_C_COMPILER clang)
set(CMAKE_C_COMPILER_TARGET ${CROSS_COMPILER_PREFIX})
set(CMAKE_ASM_COMPILER ${CROSS_COMPILER_PREFIX}-gcc)
set(CMAKE_C_LINK_EXECUTABLE "${CROSS_COMPILER_PREFIX}-ld <OBJECTS> -o <TARGET> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <LINK_LIBRARIES>")
set(CMAKE_OBJCOPY ${CROSS_COMPILER_PREFIX}-objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL ${CROSS_COMPILER_PREFIX}-size CACHE INTERNAL "size tool")

# Hard-code the ARM GCC include directory for now
include_directories(/usr/arm-none-eabi/include/)

# Set LIBC and LIBGCC
execute_process(
    COMMAND ${CROSS_COMPILER_PREFIX}-gcc -print-file-name=libc.a
    OUTPUT_VARIABLE LIBC_FILE
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
    COMMAND ${CROSS_COMPILER_PREFIX}-gcc -print-file-name=libgcc.a
    OUTPUT_VARIABLE LIBGCC_FILE
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
get_filename_component(LIBC ${LIBC_FILE} DIRECTORY)
get_filename_component(LIBGCC ${LIBGCC_FILE} DIRECTORY)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
