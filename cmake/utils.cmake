#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

# Needed to run the last objcopy stage in the compilation
#
# It would be nicer if this could fit in the toolchain file instead, since then
# no modifications to the app CMakeLists.txt would be necessary.
function(generate_binary target)
    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/images)
    add_custom_command(
        TARGET ${target}
        POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O binary ${target} ${CMAKE_BINARY_DIR}/images/${target}.bin
    )
endfunction()

function(assert value msg)
    if(NOT ${value})
        message(FATAL_ERROR "Assertion failure: " ${msg})
    endif()
endfunction()
