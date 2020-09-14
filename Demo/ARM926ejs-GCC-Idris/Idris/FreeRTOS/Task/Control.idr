module FreeRTOS.Task.Control

import Utils

%default total

||| An identifier of a Task
public export
data TID : Type where
     MkTID : (tid : AnyPtr) -> TID

%foreign "C:xTaskGetCurrentTaskHandle,libFreeRTOS"
prim_xTaskGetCurrentTaskHandle : PrimIO AnyPtr

||| The handle of the currently running (calling) task.
getCurrentTaskTID : IO TID
getCurrentTaskTID = do
  ptr <- primIO $ prim_xTaskGetCurrentTaskHandle
  pure (MkTID ptr)

%foreign "C:xTaskCreate,libFreeRTOS"
prim_xTaskCreate : (PrimIO ()) -> Int -> PrimIO AnyPtr

||| Create a new task and add it to the list of tasks that are ready to run.
||| Returns `Nothing` if required memory couldn't be allocated.
export
create : (function : IO ()) -> IO (Maybe TID)
create func = do
    let etc = 0 -- TODO: pass the rest of the arguments to xTaskCreate
    ptr <- primIO $ prim_xTaskCreate (toPrim func) etc
    if !(nullPtr ptr)
        then pure Nothing
        else pure (Just (MkTID ptr))

%foreign "C:vTaskDelete,libFreeRTOS"
prim_vTaskDelete : AnyPtr -> PrimIO ()

||| Remove a task from the RTOS kernels management.
export
delete : IO ()
delete = do
    MkTID handle <- getCurrentTaskTID
    primIO $ prim_vTaskDelete handle

%foreign "C:wrapper_vTaskDelay,libFreeRTOS"
prim_wrapper_vTaskDelay : Int -> PrimIO ()

||| Delay the task `ms` number of milliseconds.
export
delay : Int -> IO ()
delay ms =
    primIO $ prim_wrapper_vTaskDelay ms

%foreign "C:uxTaskPriorityGet,libFreeRTOS"
prim_uxTaskPriorityGet : TID -> PrimIO Int

||| Obtain the priority of any task.
getPriority : TID -> IO Int
getPriority (MkTID ptr) =
    primIO $ prim_uxTaskPriorityGet (MkTID ptr)

%foreign "C:vTaskPrioritySet,libFreeRTOS"
prim_vTaskPrioritySet : TID -> Int -> PrimIO ()

||| Set the priority of any task.
setPriority : TID -> Int -> IO ()
setPriority (MkTID ptr) prio =
    primIO $ prim_vTaskPrioritySet (MkTID ptr) prio

%foreign "C:vTaskSuspend,libFreeRTOS"
prim_vTaskSuspend : TID -> PrimIO ()

||| Suspend any task. When suspended a task will never get any microcontroller processing time, no
||| matter what its priority.
suspend : TID -> IO ()
suspend (MkTID ptr) =
    primIO $ prim_vTaskSuspend (MkTID ptr)

%foreign "C:vTaskResume,libFreeRTOS"
prim_vTaskResume : TID -> PrimIO ()

||| Resumes a suspended task.
resume : TID -> IO ()
resume (MkTID ptr) =
    primIO $ prim_vTaskResume (MkTID ptr)
