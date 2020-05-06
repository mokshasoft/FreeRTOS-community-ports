module FreeRTOS.Task.Utils

import FreeRTOS.Task.Control

%default total

||| The handle of the currently running (calling) task.
getCurrentTaskTID : IO TID
getCurrentTaskTID = do
    ptr <- cCall AnyPtr "xTaskGetCurrentTaskHandle" []
    pure (MkTID ptr)

||| The task handle associated with the Idle task.
getIdleTaskHandle : IO TID
getIdleTaskHandle = do
    ptr <- cCall AnyPtr "xTaskGetIdleTaskHandle" []
    pure (MkTID ptr)

||| Looks up the name of a task from the task’s handle.
getName : TID -> IO String
getName (MkTID ptr) =
    cCall String "pcTaskGetName" [ptr]

||| The number of tasks that the RTOS kernel is currently managing.
getNbrTasks : IO Int
getNbrTasks =
    cCall Int "uxTaskGetNumberOfTasks" []
