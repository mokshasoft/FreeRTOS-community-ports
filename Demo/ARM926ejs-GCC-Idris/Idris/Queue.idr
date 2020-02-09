{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module Queue

%default total

%include C "wrapper.h"
%include C "idris_rts.h"

-- A QueueHandle
export
data QueueHandle : Type -> Type where
    MkQueueHandle : (handle : Ptr) -> QueueHandle itemType

{-
  QueueHandle_t xQueueCreate(
      UBaseType_t uxQueueLength,
      UBaseType_t uxItemSize);
-}
export
queueCreate : (itemType : Type) -> Int -> IO (Maybe (QueueHandle itemType))
queueCreate _ len = do
    let item_size = 8
    ptr <- foreign FFI_C "wrapper_xQueueCreate" (Int -> Int -> IO Ptr) len item_size
    if !(nullPtr ptr)
        then pure Nothing
        else pure (Just (MkQueueHandle ptr))

{-
  void vQueueDelete(QueueHandle_t xQueue);
-}
export
queueDelete : QueueHandle itemType -> IO ()
queueDelete (MkQueueHandle handle) =
    foreign FFI_C "wrapper_vQueueDelete" (Ptr -> IO ()) handle

{-
  BaseType_t xQueueSend(
      QueueHandle_t xQueue,
      const void * pvItemToQueue,
      TickType_t xTicksToWait);
  Only send and receive Ints for now
-}
export
queueSend : QueueHandle itemType -> itemType -> IO ()
queueSend {itemType} (MkQueueHandle handle) value =
    foreign FFI_C "idris_queueSend" (Ptr -> Raw itemType -> IO ()) handle (MkRaw value)

{-
  BaseType_t xQueueReceive(
      QueueHandle_t xQueue,
      void *pvBuffer,
      TickType_t xTicksToWait);
  Only send and receive Ints for now
-}
export
queueReceive : QueueHandle itemType -> IO itemType
queueReceive (MkQueueHandle handle) = ?recQueue
