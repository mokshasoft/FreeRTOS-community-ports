{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module Utils

%access public export
%default total

%include C "print.h"

-- void vDirectPrintMsg(const portCHAR* msg);
vDirectPrintMsg : String -> IO ()
vDirectPrintMsg msg =
    foreign FFI_C "vDirectPrintMsg" (String -> IO ()) msg
