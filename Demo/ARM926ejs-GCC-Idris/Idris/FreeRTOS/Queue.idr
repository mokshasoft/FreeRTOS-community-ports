{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module FreeRTOS.Queue

%default total

||| A handle to a queue
||| Use an Int for Idris2 instead of Ptr
export
data QueueHandle : Type -> Type where
    MkQueueHandle : (handle : AnyPtr) -> QueueHandle itemType

%foreign "C:wrapper_xQueueCreate,libsmall"
prim_wrapper_xQueueCreate : Int -> PrimIO AnyPtr

wrapper_xQueueCreate: Int -> IO AnyPtr
wrapper_xQueueCreate s = primIO $ prim_wrapper_xQueueCreate s

%foreign "C:isNull,libsmall"
nullPtr : AnyPtr -> Bool

||| Create a queue.
export
create : (itemType : Type) -> Int -> IO (Maybe (QueueHandle itemType))
create _ len = do
    ptr <- wrapper_xQueueCreate len
    if nullPtr ptr
        then pure Nothing
        else pure (Just (MkQueueHandle ptr))

%foreign "C:wrapper_vQueueDelete,libsmall"
prim_wrapper_vQueueDelete : AnyPtr -> PrimIO ()

wrapper_vQueueDelete : AnyPtr -> IO ()
wrapper_vQueueDelete p = primIO $ prim_wrapper_vQueueDelete p

||| Delete a queue.
export
delete : QueueHandle itemType -> IO ()
delete (MkQueueHandle handle) =
    wrapper_vQueueDelete handle

||| Put an element at the end of the queue, block until not full.
export
put : QueueHandle itemType -> itemType -> IO ()
put {itemType} (MkQueueHandle handle) value =
    foreign FFI_C "idris_queuePut" (Ptr -> Raw itemType -> IO ()) handle (MkRaw value)

||| Get an element from the front of the queue, block until an item is available.
export
get : QueueHandle itemType -> IO itemType
get {itemType} (MkQueueHandle handle) = do
    me <- getMyVM
    MkRaw x <- foreign FFI_C "idris_queueGet" (Ptr -> Ptr -> IO (Raw itemType)) me handle
    pure x
