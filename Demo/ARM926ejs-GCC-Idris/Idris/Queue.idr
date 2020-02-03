{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module Queue

%default total

%include C "wrapper.h"

||| A QueueHandle
export
data QueueHandle : Type where
     MkQueueHandle : (handle : Ptr) -> QueueHandle

{-
  QueueHandle_t xQueueCreate(
      UBaseType_t uxQueueLength,
      UBaseType_t uxItemSize);
-}
export
xQueueCreate : Int -> Int -> IO (Maybe QueueHandle)
xQueueCreate len item_size = do
    ptr <- foreign FFI_C "wrapper_xQueueCreate" (Int -> Int -> IO Ptr) len item_size
    if !(nullPtr ptr)
        then pure Nothing
        else pure (Just (MkQueueHandle ptr))

{-
  void vQueueDelete(QueueHandle_t xQueue);
-}
export
vQueueDelete : QueueHandle -> IO ()
vQueueDelete (MkQueueHandle handle) =
    foreign FFI_C "wrapper_vQueueDelete" (Ptr -> IO ()) handle

{-
  BaseType_t xQueueSend(
      QueueHandle_t xQueue,
      const void * pvItemToQueue,
      TickType_t xTicksToWait);
-}

{-
   BaseType_t xQueueReceive(
       QueueHandle_t xQueue,
       void *pvBuffer,
       TickType_t xTicksToWait);
-}
