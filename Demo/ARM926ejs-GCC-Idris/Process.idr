{-
Copyright 2020, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module Process

%access public export
%default total

pdPASS : Int
pdPASS = 1

pdFAIL : Int
pdFAIL = 0

Task : Type
Task = Int

{-
    BaseType_t xTaskCreate(
        TaskFunction_t pvTaskCode,
        const char * const pcName,
        configSTACK_DEPTH_TYPE usStackDepth,
        void *pvParameters,
        UBaseType_t uxPriority,
        TaskHandle_t *pxCreatedTask
    );
-}
xTaskCreate :
    (task : Task) ->
    (name : String) ->
    (stackDepth : Int) ->
    (priority : Int) ->
    IO Int
xTaskCreate task name stackDepth priority =
    foreign FFI_C "xTaskCreate" (Task -> String -> Int -> Int -> IO Int) task name stackDepth priority
