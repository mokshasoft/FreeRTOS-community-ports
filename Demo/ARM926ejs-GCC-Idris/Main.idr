{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module Main

import System.Concurrency.Channels
import Process
import Utils

printer : IO ()
printer = do
    vDirectPrintMsg "Printing from printer..\n"
    vTaskDelay 2000
    printer

main : IO ()
main = do
    Just pidPrinter <- spawn printer | Nothing => vDirectPrintMsg "spawning printer failed"
    vDirectPrintMsg "Hello, Idris Unikernel\n"
