#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

# Include Idris CMake functions
include(${CMAKE_SOURCE_DIR}/cmake/Idris.cmake)
test_idris_version(1.3.1)

set(APP demo-ARM926ejs-Idris)
project(transcompile-${APP})

# Idris app source
set(APP_DIR ${CMAKE_CURRENT_SOURCE_DIR})
file(GLOB idris_main
    ${APP_DIR}/Main.idr
)
file(GLOB idris_src
    ${APP_DIR}/*.idr
)

# Transcompile app
idris_tc_files(${APP}-main.c ${idris_main} ${idris_src})
