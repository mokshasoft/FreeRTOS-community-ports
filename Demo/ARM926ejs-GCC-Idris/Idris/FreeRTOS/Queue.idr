{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module FreeRTOS.Queue

import Utils

%default total

||| A handle to a queue
||| Use an Int for Idris2 instead of Ptr
export
data QueueHandle : Type -> Type where
    MkQueueHandle : (handle : AnyPtr) -> QueueHandle itemType

%foreign "C:wrapper_xQueueCreate,libwrapperFreeRTOS"
prim_wrapper_xQueueCreate : Int -> PrimIO AnyPtr

wrapper_xQueueCreate: Int -> IO AnyPtr
wrapper_xQueueCreate s = primIO $ prim_wrapper_xQueueCreate s

||| Create a queue.
export
create : (itemType : Type) -> Int -> IO (Maybe (QueueHandle itemType))
create _ len = do
    ptr <- wrapper_xQueueCreate len
    if !(nullPtr ptr)
        then pure Nothing
        else pure (Just (MkQueueHandle ptr))

%foreign "C:wrapper_vQueueDelete,libwrapperFreeRTOS"
prim_wrapper_vQueueDelete : AnyPtr -> PrimIO ()

wrapper_vQueueDelete : AnyPtr -> IO ()
wrapper_vQueueDelete p = primIO $ prim_wrapper_vQueueDelete p

||| Delete a queue.
export
delete : QueueHandle itemType -> IO ()
delete (MkQueueHandle handle) =
    wrapper_vQueueDelete handle

%foreign "C:idris_queuePut,libwrapperFreeRTOS"
prim_idris_queuePut : AnyPtr -> AnyPtr -> PrimIO ()

||| Put an element at the end of the queue, block until not full.
export
put : {itemType : _} -> QueueHandle itemType -> itemType -> IO ()
put {itemType} (MkQueueHandle handle) value =
  primIO $ prim_idris_queuePut handle (?valueToPtr value)

%foreign "C:idris_queueGet,libwrapperFreeRTOS"
prim_idris_queueGet : AnyPtr -> PrimIO AnyPtr

||| Get an element from the front of the queue, block until an item is available.
export
get : {itemType : _} -> QueueHandle itemType -> IO itemType
get {itemType} (MkQueueHandle handle) = do
  ptr <- primIO $ prim_idris_queueGet handle
  pure (?ptrToValue ptr)
