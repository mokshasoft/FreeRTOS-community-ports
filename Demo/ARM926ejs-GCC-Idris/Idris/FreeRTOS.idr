{-
Copyright (c) 2011 Edwin Brady
    School of Computer Science, University of St Andrews
All rights reserved.

This code is derived from software written by Edwin Brady
(eb@cs.st-andrews.ac.uk).

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. None of the names of the copyright holders may be used to endorse
   or promote products derived from this software without specific
   prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*** End of disclaimer. ***
-}

module FreeRTOS

||| A Channel is a connection between two processes. Channels can be created
||| either using 'listen' to wait for an incoming connection, or 'connect'
||| which initiates a connection to another process.
||| Channels cannot (yet) be passed between processes.
export
data Channel : Type where
     MkConc : (pid : Ptr) -> (ch_id : Int) -> Channel

||| A PID is a process identifier, as returned by `spawn`
export
data PID : Type where
     MkPID : (pid : Ptr) -> PID

||| Spawn a process in a new thread, returning the process ID
||| Returns `Nothing` if there are not enough resources to create the new thread
export
spawn : (process : IO ()) -> IO (Maybe PID)
spawn proc = do
    pid <- fork proc
    if !(nullPtr pid)
        then pure Nothing
        else pure (Just (MkPID pid))

||| Create a channel which connects this process to another process
export
connect : (pid : PID) -> IO (Maybe Channel)
connect (MkPID pid) = do
    vm <- getMyVM
    ch_id <- foreign FFI_C "idris_connect" (Ptr -> Ptr -> IO Int) vm pid
    if (ch_id /= 0)
        then pure (Just (MkConc pid ch_id))
        else pure Nothing

||| Listen for incoming connections. If another process has initiated a
||| communication with this process, returns a channel 
export
listen : (timeout : Int) -> IO (Maybe Channel)
listen timeout =
    ?listen_impl

||| Send a message on a channel. Returns whether the message was successfully
||| sent to the process at the other end of the channel. This will fail if
||| the process on the channel is no longer running.
||| This is unsafe because there is no type checking, so there must be
||| a protocol (externally checked) which ensures that the message send
||| is of type expected by the receiver.
export
unsafeSend : Channel -> (val : a) -> IO Bool
unsafeSend (MkConc pid ch_id) val =
    ?undsafeSend_impl

||| Receive a message on a channel, with an explicit type.
||| Blocks if there is nothing to receive. Returns `Nothing` if the
||| process on the channel is no longer running.
||| This is unsafe because there is no type checking, so there must be
||| a protocol (externally checked) which ensures that the message received
||| is of the type given by the sender.
export
unsafeRecv : (expected : Type) -> Channel -> IO (Maybe expected)
unsafeRecv a (MkConc pid ch_id) =
    ?unsafeRecv_impl

||| Exit the thread immediately
export
stopThread : IO ()
stopThread = do
    vm <- getMyVM
    foreign FFI_C "idris_stopThread" (Ptr -> IO ()) vm
