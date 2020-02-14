#include "idris_gmp.h"
#include "idris_opts.h"
#include "idris_rts.h"
#include "idris_stats.h"
#include "print.h"
#include <FreeRTOS.h>
#include <task.h>

void _idris__123_runMain_95_0_125_(VM* vm, VAL* oldbase);

RTSOpts opts = {
    .init_heap_size = 10000,
    .max_stack_size = 5000,
    .show_summary   = 0
};

static void uartLog(const char* msg) {
    vDirectPrintMsg(msg);
}

static void halt() {
    for (; ;);
}

void vRootThread(void* pvParameters) {
    VM* vm = init_vm(opts.max_stack_size, opts.init_heap_size, 1);
    init_gmpalloc();
    init_nullaries();
    _idris__123_runMain_95_0_125_(vm, NULL);
}

int main() {
    // Init print
    if (pdFAIL == printInit(0)) {
        uartLog("Init print failed\r\n");
        halt();
    }

    // Create root thread
    if (pdPASS != xTaskCreate(vRootThread, "root", 2000, NULL, 0, NULL)) {
        uartLog("Failed to create root thread\r\n");
        halt();
    }

    // Start the FreeRTOS scheduler
    vTaskStartScheduler();

    // Will not get here unless there is insufficient RAM
    uartLog("will not get here\r\n");
    return EXIT_SUCCESS;
}
