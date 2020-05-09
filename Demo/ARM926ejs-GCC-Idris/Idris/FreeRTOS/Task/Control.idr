module FreeRTOS.Task.Control

import Utils

%default total

||| An identifier of a Task
public export
data TID : Type where
     MkTID : (tid : AnyPtr) -> TID

||| The handle of the currently running (calling) task.
getCurrentTaskTID : IO TID
getCurrentTaskTID = do
    ptr <- cCall AnyPtr "xTaskGetCurrentTaskHandle" []
    pure (MkTID ptr)

||| Create a new task and add it to the list of tasks that are ready to run.
||| Returns `Nothing` if required memory couldn't be allocated.
export
create : (function : IO ()) -> IO (Maybe TID)
create func = do
    let etc = 0 -- TODO: pass the rest of the arguments to xTaskCreate
    ptr <- cCall AnyPtr "xTaskCreate" [func, etc]
    if !(nullPtr ptr)
        then pure Nothing
        else pure (Just (MkTID ptr))

||| Remove a task from the RTOS kernels management.
export
delete : IO ()
delete = do
    MkTID handle <- getCurrentTaskTID
    cCall () "vTaskDelete" [handle]

||| Delay the task `ms` number of milliseconds.
export
delay : Int -> IO ()
delay ms =
    cCall () "wrapper_vTaskDelay" [ms]

||| Obtain the priority of any task.
getPriority : TID -> IO Int
getPriority (MkTID ptr) =
    cCall Int "uxTaskPriorityGet" [ptr]

||| Set the priority of any task.
setPriority : TID -> Int -> IO ()
setPriority (MkTID ptr) prio =
    cCall () "vTaskPrioritySet" [ptr, prio]

||| Suspend any task. When suspended a task will never get any microcontroller processing time, no
||| matter what its priority.
suspend : TID -> IO ()
suspend (MkTID ptr) =
    cCall () "vTaskSuspend" [ptr]

||| Resumes a suspended task.
resume : TID -> IO ()
resume (MkTID ptr) =
    cCall () "vTaskResume" [ptr]
