#ifndef PROCESSING_H
#define PROCESSING_H

#if !defined(_MSC_VER)
#   include <cstddef>
#endif
#include <cstdint>
using std::uint8_t;
using std::uint16_t;
using std::uint_fast8_t;
using std::size_t;

class Processing
{
public:
    Processing();

    void process();

    const uint8_t * getData();
private:
    uint8_t data[10];
};

#endif // PROCESSING_H
