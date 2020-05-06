{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module Main

import FreeRTOS.Queue
import FreeRTOS.Task.Control as TC
import FreeRTOS.Task.Utils
import Utils

{-
 - Printer loop
 -}

printer : Int -> IO ()
printer 0 = do
    vDirectPrintMsg "Stopping printer thread\n"
    TC.delete
printer n = do
    vDirectPrintMsg "Printing from printer..\n"
    TC.delay 2000
    printer (n - 1)

{-
 - Receiver of items from Queue
 -}

receiver : Int -> QueueHandle Int -> IO ()
receiver 0 handle = do
    vDirectPrintMsg "Stopping receiver thread\n"
    delete handle
    TC.delete
receiver n handle = do
    val <- get handle
    vDirectPrintMsg $ "received: " ++ show val ++ "\n"
    TC.delay 1000
    receiver (n - 1) handle

{-
 - Sender of items to Queue
 -}

sender : Int -> QueueHandle Int -> IO ()
sender 0 _ = do
    vDirectPrintMsg "Stopping sender thread\n"
    TC.delete
sender n handle = do
    let val = 123
    vDirectPrintMsg $ "sending " ++ show val ++ "\n"
    put handle val
    TC.delay 1000
    sender (n - 1) handle

{-
 - Main program
 -}

main : IO ()
main = do
    vDirectPrintMsg "Hello, Idris Unikernel\n"
    -- Start printer
    Just pidPrinter <- TC.create (printer 5) | Nothing => vDirectPrintMsg "starting printer failed\n"
    -- Create queue
    Just handle <- create Int 2 | Nothing => vDirectPrintMsg "Could not create queue\n"
    -- Start receiver
    Just pidRec <- TC.create (receiver 3 handle) | Nothing => vDirectPrintMsg "starting receiver failed\n"
    -- Start sender
    Just pidSend <- TC.create (sender 3 handle) | Nothing => vDirectPrintMsg "starting sender failed\n"
    vDirectPrintMsg "sender and receiver started\n"
