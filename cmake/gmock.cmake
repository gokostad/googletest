###
## Copyright (c) 2015 General Electric Company. All rights reserved.
##

find_package(Threads)

include(ExternalProject)

# Define compile flags for GoogleMock. Disable extra warning flags.
set(GMOCK_DISABLED_FLAGS_REGEX -W[a-z-]*)
string(REGEX REPLACE "${GMOCK_DISABLED_FLAGS_REGEX}" "" GMOCK_CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REGEX REPLACE "${GMOCK_DISABLED_FLAGS_REGEX}" "" GMOCK_CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

# Download and install GoogleMock
set(DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/ThirdParty)
set(GMOCK_VERSION gmock-1.7.0)
set(GMOCK_DIR ${GMOCK_VERSION})
set(GMOCK_FILE ${GMOCK_VERSION}.zip)
set(GMOCK_PATH ${DOWNLOAD_DIR}/${GMOCK_DIR})
set(GMOCK_FILE_PATH ${DOWNLOAD_DIR}/${GMOCK_FILE})
set(GMOCK_DOWNLOAD_URL https://github.com/google/googletest/archive/master.zip) # http://googlemock.googlecode.com/files/${GMOCK_FILE})
set(GMOCK_NEED_DOWNLOAD 1)
if("${CMAKE_TOOLCHAIN_FILE}" STREQUAL "")
    set(GMOCK_CMAKE_TOOLCHAIN_ARGS -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER})
else()
    set(GMOCK_CMAKE_TOOLCHAIN_ARGS -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE})
endif()
set(GMOCK_CMAKE_ARGS ${GMOCK_CMAKE_TOOLCHAIN_ARGS} -DCMAKE_C_FLAGS=${GMOCK_CMAKE_C_FLAGS} -DCMAKE_CXX_FLAGS=${GMOCK_CMAKE_CXX_FLAGS})
set(GMOCK_THREAD_LIBS ${CMAKE_THREAD_LIBS_INIT})
set(GMOCK_PATCH_COMMAND "")

# Check from GMOCK_PATH environment variable if GMock zip file is downloaded to some other directory. This allows
# using same downloaded package in multiple different repositories.
find_path(GMOCK_LOCAL_INSTALL_DIR
    NAMES ${GMOCK_FILE}
    PATHS $ENV{GMOCK_PATH}
)

if(NOT "${GMOCK_LOCAL_INSTALL_DIR}" STREQUAL "GMOCK_LOCAL_INSTALL_DIR-NOTFOUND")
    set(GMOCK_FILE_PATH "${GMOCK_LOCAL_INSTALL_DIR}/${GMOCK_FILE}")
endif()

# To prevent multiple downloads, the URL is set to the directory
# where GMock was downloaded, if it exists
if(EXISTS ${GMOCK_FILE_PATH})
    set(GMOCK_DOWNLOAD_URL ${GMOCK_FILE_PATH})
endif()

# MSYS and Cygwin create problems with GMock when pthreads
# are used. In those cases, pthreads are disabled for the GMock
# build and for builds depending on GMock.
if(MSYS OR CYGWIN OR MINGW)
    set(GMOCK_CMAKE_ARGS ${GMOCK_CMAKE_ARGS} -Dgtest_disable_pthreads=1)
    set(GMOCK_THREAD_LIBS "")
endif()

find_program(PATCH_EXECUTABLE
    NAMES
        patch
        patch.exe
)
if(NOT "${PATCH_EXECUTABLE}" STREQUAL "PATCH_EXECUTABLE-NOTFOUND")
    # Patch GTest to output colors in MSYS2 MinGW terminal
    set(GMOCK_PATCH_COMMAND patch -N -t -p1 -u -i ${DOWNLOAD_DIR}/msys2-mingw-terminal-colors.patch )
endif()

message(STATUS "Goran: Get gmock- URL:" ${GMOCK_DOWNLOAD_URL} " -SOURCE_DIR:" ${GMOCK_PATH} " -DOWNLOAD_NAME:" ${GMOCK_FILE}
" -DOWNLOAD_DIR:" ${DOWNLOAD_DIR} )


ExternalProject_Add(
    gmock
    URL ${GMOCK_DOWNLOAD_URL}
    SOURCE_DIR ${GMOCK_PATH}
    DOWNLOAD_NAME ${GMOCK_FILE}
    DOWNLOAD_DIR ${DOWNLOAD_DIR}
    CMAKE_ARGS ${GMOCK_CMAKE_ARGS}
    PATCH_COMMAND ${GMOCK_PATCH_COMMAND}
    URL_HASH SHA512=0ab7bb2614f8c00e4842a6819dbc6d9323c42241335078c23eaee53ed420d42f1845d44334eccbf7c114cc88f6ac7a493e20d9b46c58cdba645bbd400eb6db55
    # Disable install step
    INSTALL_COMMAND ""
    EXCLUDE_FROM_ALL 1
    )

# Create a libgmock target to be used as a dependency by test programs
add_library(libgmock IMPORTED STATIC GLOBAL)
add_dependencies(libgmock gmock)

# Set gmock properties
ExternalProject_Get_Property(gmock source_dir binary_dir)
set_target_properties(libgmock PROPERTIES
    "IMPORTED_LOCATION" "${binary_dir}/libgmock.a"
    "IMPORTED_LINK_INTERFACE_LIBRARIES" "${GMOCK_THREAD_LIBS}"
)
include_directories("${source_dir}/include")
include_directories(SYSTEM "${source_dir}/gtest/include")
