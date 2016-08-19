###
## Copyright (c) 2015 General Electric Company. All rights reserved.
##

set(COMMON_C_CXX_FLAGS "\
-Wall -Wextra -Werror -Wfatal-errors -Wshadow -Wpedantic -pedantic-errors -Wdouble-promotion \
-Wswitch-default -Wswitch-enum\
")

if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 5.1)
    set(COMMON_C_CXX_FLAGS "${COMMON_C_CXX_FLAGS} -Wno-missing-field-initializers")
endif()

set(CMAKE_C_FLAGS "${COMMON_C_CXX_FLAGS} -std=c99")
set(CMAKE_CXX_FLAGS "${COMMON_C_CXX_FLAGS} -std=gnu++0x -fno-rtti")

# Compiler flags per build type. Types allowed:
# DEBUG | RELEASE | RELWITHDEBINFO | MINSIZEREL
set(OPTIMIZE_DEBUG "-O0 -g3")
set(CMAKE_C_FLAGS_DEBUG ${OPTIMIZE_DEBUG})
set(CMAKE_CXX_FLAGS_DEBUG ${OPTIMIZE_DEBUG})
