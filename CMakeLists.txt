# CMakeLists.txt for building the mcufs library.
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

# Define project name
project(mcufs_proj CXX C)

# Add a static library target
add_library(mcufs STATIC
    src/romfs.cpp
    src/crc32.cpp
)

target_include_directories(mcufs PUBLIC ${PROJECT_SOURCE_DIR}/include)

if("${CMAKE_BUILD_TYPE}" STREQUAL "")
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Default configuration is debug" FORCE)
endif()

# Set compile options for compiling the library
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  # using GCC
  set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -lstdc++ -pedantic -Wall -Wextra -Werror -fno-strict-aliasing")
  set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99 -Wmissing-prototypes -Wall -Wextra -Werror -fno-strict-aliasing")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  # using Clang
  set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -pedantic -Wall -Wextra -Weverything")
  set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99 -Wall -Wextra -Weverything")
endif()

# Define public headers
set(public_headers
    include/romfs/romfs.h
    include/target/mcufs_hw.h
)

set_target_properties(mcufs PROPERTIES PUBLIC_HEADER "${public_headers}")

install(TARGETS mcufs
  ARCHIVE DESTINATION lib
  PUBLIC_HEADER DESTINATION include/romfs
)

add_subdirectory(src)

if ("${DEVICE_PLATFORM}" STREQUAL "DESKTOP")
    add_subdirectory(tests)
endif()
