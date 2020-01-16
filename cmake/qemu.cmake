#
# Copyright 2020, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

function(create_qemu_target target)
    assert(PLATFORM "Variable PLATFORM has to be set to use create_qemu_target")

    # Run the app in QEMU
    add_custom_target(qemu.${target} DEPENDS ${target})
    add_custom_command(
        TARGET qemu.${target}
        POST_BUILD
        COMMAND qemu-system-arm -M ${PLATFORM} -m 128M -nographic -kernel ${CMAKE_BINARY_DIR}/images/${target}.bin
        USES_TERMINAL
    )
    # Start qemu and open a gdbserver on TCP port 1234
    add_custom_target(gdbserver.${target} DEPENDS ${target})
    add_custom_command(
        TARGET gdbserver.${target}
        POST_BUILD
        COMMAND qemu-system-arm -M ${PLATFORM} -m 128M -nographic -kernel ${CMAKE_BINARY_DIR}/images/${target}.bin -s -S
        USES_TERMINAL
    )
    # Start gdb and break on _start
    add_custom_target(gdb.${target} DEPENDS ${target})
    add_custom_command(
        TARGET gdb.${target}
        POST_BUILD
        COMMAND ${CROSS_COMPILER_PREFIX}-gdb -ex 'target remote :1234' -ex 'b _start' ${target}
        USES_TERMINAL
    )
endfunction()
