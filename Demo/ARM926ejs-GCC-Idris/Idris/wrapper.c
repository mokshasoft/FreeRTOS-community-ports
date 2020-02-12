/*
 * Copyright 2020, Mokshasoft AB (mokshasoft.com)
 *
 * This software may be distributed and modified according to the terms of
 * the GNU General Public License version 2. Note that NO WARRANTY is provided.
 * See "LICENSE_BSD2.txt" for details.
 */

#include "wrapper.h"

void wrapper_vTaskDelay(int delay_ms)
{
    vTaskDelay(delay_ms/portTICK_RATE_MS);
}

QueueHandle_t wrapper_xQueueCreate(
    UBaseType_t uxQueueLength,
    UBaseType_t uxItemSize)
{
    return xQueueCreate(uxQueueLength, uxItemSize);
}

void wrapper_vQueueDelete(QueueHandle_t xQueue)
{
    vQueueDelete(xQueue);
}
