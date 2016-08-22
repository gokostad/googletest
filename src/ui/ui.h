#ifndef UI_H
#define UI_H

#if !defined(_MSC_VER)
#   include <cstddef>
#endif
#include <cstdint>
using std::uint8_t;
using std::uint16_t;
using std::uint_fast8_t;
using std::size_t;

class UI
{
public:
    UI();

    void init();
    void show();
};

#endif // UI_H
