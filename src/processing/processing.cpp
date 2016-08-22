#include "processing.h"

#include "uartdriver.h"
#include "spidriver.h"

Processing::Processing()
{
}

void Processing::process()
{
    uartSend(data, sizeof(data));
    uartReceiveDataBlocking(data, sizeof(data));

    spiSend(data, sizeof(data));
    spiReceiveDataBlocking(data, sizeof(data));
}

const uint8_t * Processing::getData()
{
    return data;
}
