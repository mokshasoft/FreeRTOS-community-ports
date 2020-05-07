#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

set(LIB wrapperFreeRTOS)
project(${LIB})

file(GLOB libsrc
    *.c
)

add_library(${LIB} EXCLUDE_FROM_ALL ${libsrc})
target_link_libraries(${LIB} FreeRTOS)
target_include_directories(${LIB} PUBLIC .)
