# Code coverage
###############
# find_package(PythonInterp REQUIRED)
# if(NOT CMAKE_SYSTEM_NAME STREQUAL Windows)
#    include(CodeCoverage)
# endif()

add_subdirectory(unittest)

# Compilation flags
###################
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage")
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fprofile-arcs -ftest-coverage")
