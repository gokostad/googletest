#include "spidriver.h"

#include <stdlib.h>

void spiSend(uint8_t *pData, size_t size)
{
    if (pData == NULL || size == 0)
    {
        return;
    }
    size_t i = 10000;
    while (i > 0)
    {
        i--;
    };
}

size_t spiReceiveDataBlocking(uint8_t* pData, size_t maxSize)
{
    if (pData == NULL)
    {
        return 0;
    }
    for (size_t i = 0; i < maxSize; i++)
    {
        pData[i] = i % 10;
    }
    return maxSize;
}
