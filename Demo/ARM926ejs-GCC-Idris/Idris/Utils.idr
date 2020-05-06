{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module Utils

%default total

||| FFI wrapper for 'int16_t printInit(uint16_t uart_nr)'
%foreign "C:printInit,libsmall"
prim_printInit : Int -> PrimIO Int

printInit : Int -> IO Int
printInit s = primIO $ prim_printInit s

||| FFI wrapper for 'void vDirectPrintMsg(const portCHAR* msg)'
export
vDirectPrintMsg : String -> IO ()
vDirectPrintMsg msg =
    cCall () "vDirectPrintMsg" [msg]
