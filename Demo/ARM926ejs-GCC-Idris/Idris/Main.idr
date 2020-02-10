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

printerLoop : Int -> IO ()
printerLoop 0 = do
    vDirectPrintMsg "Stopping printer thread\n"
    stopThread
printerLoop n = do
    vDirectPrintMsg "Printing from printer..\n"
    vTaskDelay 2000
    printerLoop (n - 1)

printer : Int -> IO ()
printer nbr =
    printerLoop nbr

{-
 - Receiver of items from Queue
 -}

receiver : QueueHandle itemType -> IO ()
receiver handle = do
    vDirectPrintMsg "receiver\n"
    vTaskDelay 1000
    receiver handle

{-
 - Sender of items to Queue
 -}

sender : QueueHandle itemType -> IO ()
sender handle = do
    vDirectPrintMsg "sender\n"
    vTaskDelay 1000
    sender handle

{-
 - Main program
 -}

main : IO ()
main = do
    vDirectPrintMsg "Hello, Idris Unikernel\n"
    -- Start printer
    Just pidPrinter <- spawn (printer 5) | Nothing => vDirectPrintMsg "spawning printer failed\n"
    -- Create queue
    Just handle <- queueCreate Int 8 | Nothing => vDirectPrintMsg "Could not create queue\n"
    queueSend handle 5
    --queueSend handle "str"
    -- Start receiver
    Just pidRec <- spawn (receiver handle) | Nothing => vDirectPrintMsg "spawning receiver failed\n"
    -- Start sender
    Just pidSend <- spawn (sender handle) | Nothing => vDirectPrintMsg "spawning sender failed\n"
    vDirectPrintMsg "sender and receiver started\n"
