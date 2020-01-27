#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

project(FreeRTOS-community-ports)

include(cmake/utils.cmake)
include(cmake/qemu.cmake)

# Add demos

add_subdirectory(Demo/AM3359_BeagleBone_GCC)
add_subdirectory(Demo/ARM926ejs-GCC)
add_subdirectory(Demo/ARM926ejs-GCC-Idris)
