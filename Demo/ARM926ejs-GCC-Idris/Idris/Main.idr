{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module Main

import FreeRTOS
import Utils
import Queue

{-
 - Printer loop
 -}

printer : Int -> IO ()
printer 0 = do
    vDirectPrintMsg "Stopping printer thread\n"
    stopThread
printer n = do
    vDirectPrintMsg "Printing from printer..\n"
    vTaskDelay 2000
    printer (n - 1)

{-
 - Receiver of items from Queue
 -}

receiver : Int -> QueueHandle Int -> IO ()
receiver 0 handle = do
    vDirectPrintMsg "Stopping receiver thread\n"
    delete handle
    stopThread
receiver n handle = do
    val <- get handle
    vDirectPrintMsg $ "received: " ++ show val ++ "\n"
    vTaskDelay 1000
    receiver (n - 1) handle

{-
 - Sender of items to Queue
 -}

sender : Int -> QueueHandle Int -> IO ()
sender 0 _ = do
    vDirectPrintMsg "Stopping sender thread\n"
    stopThread
sender n handle = do
    let val = 123
    vDirectPrintMsg $ "sending " ++ show val ++ "\n"
    put handle val
    vTaskDelay 1000
    sender (n - 1) handle

{-
 - Main program
 -}

main : IO ()
main = do
    vDirectPrintMsg "Hello, Idris Unikernel\n"
    -- Start printer
    Just pidPrinter <- startThread (printer 5) |
        Nothing => vDirectPrintMsg "starting printer failed\n"
    -- Create queue
    Just handle <- create Int 2 |
        Nothing => vDirectPrintMsg "Could not create queue\n"
    -- Start receiver
    Just pidRec <- startThread (receiver 3 handle) |
        Nothing => vDirectPrintMsg "starting receiver failed\n"
    -- Start sender
    Just pidSend <- startThread (sender 3 handle) |
        Nothing => vDirectPrintMsg "starting sender failed\n"
    vDirectPrintMsg "sender and receiver started\n"
