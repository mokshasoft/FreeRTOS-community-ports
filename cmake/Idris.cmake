#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

set(IDRIS idris2)

# Test that the Idris version is greater than version
function(test_idris_version version)
    execute_process(
        COMMAND ${IDRIS} --version
        OUTPUT_VARIABLE IDRIS_CMD_VERSION
    )
    string(
        REGEX MATCH [0-9]+\.[0-9]+.[0-9]+
        IDRIS_VERSION ${IDRIS_CMD_VERSION}
    )
    if(${IDRIS_VERSION} VERSION_LESS ${version})
        message(FATAL_ERROR "This project needs at least Idris version ${version}")
    endif()
endfunction()

# Transcompile Idris files to C
function(idris_tc_files target idris_main other_files)
    # Get all Idris file dependencies (other_files)
    set(dep_files ${ARGV})
    list(REMOVE_AT dep_files 0 1)
    # Get the source paths (actually only from main)
    get_filename_component(src_path ${idris_main} DIRECTORY)
    # Add command
    add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}
	COMMAND IDRIS2_LIBS=/home/l337/Repository/MokshasoftGithub/FreeRTOS-community-ports/idris2_build/Demo/ARM926ejs-GCC-Idris:/home/l337/Repository/MokshasoftGithub/FreeRTOS-community-ports/idris2_build/Demo/ARM926ejs-GCC-Idris/Idris ${IDRIS} --codegen gambit --directive C -o ${CMAKE_CURRENT_BINARY_DIR}/${target} ${idris_main}
        DEPENDS ${dep_files}
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )

    add_custom_target(
        transcompile-${target}
        ALL
        DEPENDS ${target} wrapperFreeRTOS
    )
endfunction()
