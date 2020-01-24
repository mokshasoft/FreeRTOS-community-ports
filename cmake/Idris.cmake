#
# Copyright 2019, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

function(test_idris_version version)
    # Test that the Idris version is greater than 1.3.1
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

function(idris_add_module module ipkg files)
    add_custom_target(${module} DEPENDS ${ipkg} ${files})
    add_custom_command(
        TARGET ${module}
        PRE_BUILD
        COMMAND idris --install ${ipkg}
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
endfunction()

function(idris_link_libraries module libraries)
    # get the libraries
    set(libs ${ARGV})
    list(REMOVE_AT libs 0)
    # store libraries
    set_property(GLOBAL PROPERTY idris_module_link_libraries_${module} ${libs})
endfunction()

function(idris_app_link_modules app modules)
    # get the modules
    set(mods ${ARGV})
    list(REMOVE_AT mods 0)
    # store modules
    set_property(GLOBAL PROPERTY idris_app_link_modules_${app} "${mods}")
endfunction()

function(idris_add_app app srcs)
    # go through all dependent modules and find their native dependencies
    get_property(app_modules GLOBAL PROPERTY idris_app_link_modules_${app})
    foreach(mod ${app_modules})
        # get the modules dependent native libraries
        get_property(libs GLOBAL PROPERTY idris_module_link_libraries_${mod})
        if(NOT "${libs}" STREQUAL "")
            set(app_libs ${app_libs} ${libs})
        endif()
    endforeach(mod)

    # generate package command, e.g -p drivers
    set(app_link ${app_modules})
    list(TRANSFORM app_link PREPEND "-p")

    # get the apps dependent native libraries
    get_property(libs GLOBAL PROPERTY idris_module_link_libraries_${app})
    if(NOT "${libs}" STREQUAL "")
        set(app_libs ${app_libs} ${libs})
    endif()

    # add a target that transcompiles Idris to C
    add_custom_command(
        OUTPUT main.c
        COMMAND idris
            ${app_link}
            --codegen C
            --codegenonly
            -o main.c
            ${srcs}
        DEPENDS ${srcs} ${app_modules}
    )
    add_custom_target(${app}-idr2c DEPENDS main.c)

    # Compile Idris generated main.c into a library
    add_library(${app}-main EXCLUDE_FROM_ALL
        main.c
    )
    target_link_libraries(
        ${app}-main
        idris-rts-bare-metal
        core
        ${app_libs}
    )

    # Ignore warning from unused loop label in generated code in Idris RTS
    set_target_properties(${app}-main PROPERTIES COMPILE_FLAGS "-Wno-unused-label")

    # Compile and link everything to a static binary
    add_executable(${app} EXCLUDE_FROM_ALL
        # add_executable needs at least one file
        ${CMAKE_SOURCE_DIR}/core/src/dummy.c
    )

    target_link_libraries(
        ${app}
        -T ${CMAKE_SOURCE_DIR}/core/src/platforms/${PLATFORM}/memmap.ld
        --start-group
        core
        idris-rts-bare-metal
        ${app}-main
        ${app_libs}
        c
        gcc
        --end-group
        --gc-sections
    )
    generate_binary(${app})
    create_qemu_target(${app})
endfunction()
