#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

# Test that the Idris version is greater than version
function(test_idris_version version)
    execute_process(
        COMMAND idris --version
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
function(idris_tc_files target idris_main)
    add_custom_target(${target} DEPENDS ${files})
    add_custom_command(
        TARGET ${target}
	COMMAND idris -i ${ARGN} --codegen C --codegenonly -o ${target} ${idris_main}
    )
endfunction()
