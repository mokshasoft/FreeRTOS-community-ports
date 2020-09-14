module FreeRTOS.Task.Utils

import FreeRTOS.Task.Control

%default total

%foreign "C:xTaskGetIdleTaskHandle,libwrapperFreeRTOS"
prim_xTaskGetIdleTaskHandle : PrimIO TID

||| The task handle associated with the Idle task.
getIdleTaskHandle : IO TID
getIdleTaskHandle =
    primIO $ prim_xTaskGetIdleTaskHandle

%foreign "C:pcTaskGetName,libwrapperFreeRTOS"
prim_pcTaskGetName : TID -> PrimIO String

||| Looks up the name of a task from the task’s handle.
getName : TID -> IO String
getName (MkTID ptr) =
    primIO $ prim_pcTaskGetName (MkTID ptr)

%foreign "C:uxTaskGetNumberOfTasks,libwrapperFreeRTOS"
prim_uxTaskGetNumberOfTasks : PrimIO Int

||| The number of tasks that the RTOS kernel is currently managing.
getNbrTasks : IO Int
getNbrTasks =
    primIO $ prim_uxTaskGetNumberOfTasks
