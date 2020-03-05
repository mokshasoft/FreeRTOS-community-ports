module FreeRTOS.Task.Control

%default total
%include C "FreeRTOS.h"
%include C "task.h"
%include C "FreeRTOS/idris_FreeRTOS.h"

||| An identifier of a Task
public export
data TID : Type where
     MkTID : (tid : Ptr) -> TID

||| Create a new task and add it to the list of tasks that are ready to run.
||| Returns `Nothing` if required memory couldn't be allocated.
export
create : (function : IO ()) -> IO (Maybe TID)
create func = do
    ptr <- fork func
    if !(nullPtr ptr)
        then pure Nothing
        else pure (Just (MkTID ptr))

||| Remove a task from the RTOS kernels management.
export
delete : IO ()
delete = do
    vm <- getMyVM
    foreign FFI_C "idris_stopThread" (Ptr -> IO ()) vm

||| Delay the task `ms` number of milliseconds.
export
delay : Int -> IO ()
delay ms =
    foreign FFI_C "wrapper_vTaskDelay" (Int -> IO ()) ms

||| Obtain the priority of any task.
getPriority : TID -> IO Int
getPriority (MkTID ptr) = do
    foreign FFI_C "uxTaskPriorityGet" (Ptr -> IO Int) ptr

||| Set the priority of any task.
setPriority : TID -> Int -> IO ()
setPriority (MkTID ptr) prio =
    foreign FFI_C "vTaskPrioritySet" (Ptr -> Int -> IO ()) ptr prio

||| Suspend any task. When suspended a task will never get any microcontroller processing time, no
||| matter what its priority.
suspend : TID -> IO ()
suspend (MkTID ptr) =
    foreign FFI_C "vTaskSuspend" (Ptr -> IO ()) ptr

||| Resumes a suspended task.
resume : TID -> IO ()
resume (MkTID ptr) =
    foreign FFI_C "vTaskResume" (Ptr -> IO ()) ptr
