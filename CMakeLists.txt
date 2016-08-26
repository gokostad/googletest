cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

project(cmakeandgogletestexample VERSION 0.0.1)

enable_language(C CXX ASM)

if("${CMAKE_BUILD_TYPE}" STREQUAL "")
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Default configuration is debug" FORCE)
endif()

include(cmake/determine-compiler.cmake)
include(cmake/compilers/${TOOLCHAIN}.flags.cmake)
include(cmake/function_add_library.cmake)
include(cmake/install-configuration.cmake)

if (test)
  include(CTest)
  enable_testing()
  add_subdirectory(test)
else()
  add_subdirectory(src)
endif()
