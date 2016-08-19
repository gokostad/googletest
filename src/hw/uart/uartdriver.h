#ifndef UARTDRIVER
#define UARTDRIVER

#ifdef __cplusplus
#   if !defined(_MSC_VER)
#       include <cstddef>
#   endif
#   include <cstdint>
#   define INLINE  inline
using std::uint8_t;
using std::uint16_t;
using std::uint_fast8_t;
using std::size_t;
extern "C" {
#else
#   include <stdint.h>
#   if defined(_MSC_VER)
#       define INLINE
#       define bool int
#       define false 0
#       define true 1
#   else
#       include <stddef.h>  // size_t
#       include <stdbool.h>
#       define INLINE inline
#   endif
#endif

void uartSend(uint8_t *pData, size_t size);
size_t uartReceiveDataBlocking(uint8_t* pData, size_t maxSize);


#undef INLINE
#ifdef __cplusplus
}
#endif

#endif // UARTDRIVER

