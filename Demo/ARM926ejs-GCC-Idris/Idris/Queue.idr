{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module Queue

%default total

%include C "FreeRTOS/idris_FreeRTOS.h"
%include C "idris_rts.h"

||| A handle to a queue
export
data QueueHandle : Type -> Type where
    MkQueueHandle : (handle : Ptr) -> QueueHandle itemType

||| Create a queue.
export
create : (itemType : Type) -> Int -> IO (Maybe (QueueHandle itemType))
create _ len = do
    ptr <- foreign FFI_C "wrapper_xQueueCreate" (Int -> IO Ptr) len
    if !(nullPtr ptr)
        then pure Nothing
        else pure (Just (MkQueueHandle ptr))

||| Delete a queue.
export
delete : QueueHandle itemType -> IO ()
delete (MkQueueHandle handle) =
    foreign FFI_C "wrapper_vQueueDelete" (Ptr -> IO ()) handle

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
