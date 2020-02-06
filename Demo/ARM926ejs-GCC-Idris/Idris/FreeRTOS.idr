{-
Copyright (c) 2011 Edwin Brady
    School of Computer Science, University of St Andrews
Copyright 2020, Mokshasoft AB (mokshasoft.com)
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

||| Exit the thread immediately
export
stopThread : IO ()
stopThread = do
    vm <- getMyVM
    foreign FFI_C "idris_stopThread" (Ptr -> IO ()) vm
