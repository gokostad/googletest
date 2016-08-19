###
## Copyright (c) 2015 General Electric Company. All rights reserved.
##

set(COMMON_C_CXX_FLAGS "")
set(CMAKE_C_FLAGS "${COMMON_C_CXX_FLAGS} -std=c99")
set(CMAKE_CXX_FLAGS "${COMMON_C_CXX_FLAGS} -std=gnu++11")

# Compiler flags per build type. Types allowed:
# DEBUG | RELEASE | RELWITHDEBINFO | MINSIZEREL
set(OPTIMIZE_DEBUG "-O0 -g -fstandalone-debug")
set(CMAKE_C_FLAGS_DEBUG ${OPTIMIZE_DEBUG})
set(CMAKE_CXX_FLAGS_DEBUG ${OPTIMIZE_DEBUG})
