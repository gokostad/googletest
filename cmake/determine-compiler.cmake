###
## Copyright (c) 2016 General Electric Company. All rights reserved.
##

string(TOLOWER ${CMAKE_CXX_COMPILER_ID} COMPILER_ID_LOWER)

set(TOOLCHAIN_GCC "gcc")
set(TOOLCHAIN_CLANG "clang")

if("${COMPILER_ID_LOWER}" STREQUAL "gnu")
    set(TOOLCHAIN "${TOOLCHAIN_GCC}")
elseif("${COMPILER_ID_LOWER}" STREQUAL "clang")
    set(TOOLCHAIN "${TOOLCHAIN_CLANG}")
endif()

if(NOT DEFINED TOOLCHAIN)
    message(FATAL_ERROR "Unsupported compiler")
endif()
