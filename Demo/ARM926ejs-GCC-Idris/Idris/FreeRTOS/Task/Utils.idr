module FreeRTOS.Task.Utils

import FreeRTOS.Task.Control

%default total
%include C "FreeRTOS.h"
%include C "task.h"

||| The handle of the currently running (calling) task.
getCurrentTaskTID : IO TID
getCurrentTaskTID = do
    ptr <- foreign FFI_C "xTaskGetCurrentTaskHandle" (IO Ptr)
    pure (MkTID ptr)

||| The task handle associated with the Idle task.
getIdleTaskHandle : IO TID
getIdleTaskHandle = do
    ptr <- foreign FFI_C "xTaskGetIdleTaskHandle" (IO Ptr)
    pure (MkTID ptr)

||| Looks up the name of a task from the task’s handle.
getName : TID -> IO String
getName (MkTID ptr) =
    foreign FFI_C "pcTaskGetName" (Ptr -> IO String) ptr

||| The number of tasks that the RTOS kernel is currently managing.
getNbrTasks : IO Int
getNbrTasks =
    foreign FFI_C "uxTaskGetNumberOfTasks" (IO Int)
