#!/bin/bash

set -e
set -u

VERBOSE_MODE=""

usage()
{
cat << EOF

Usage: $0 [parameters]

Parameters:
    --toolchain     [gcc | clang] defines which compiler toolchain will be used
    --target        [app | test] defines the build target board
    --help          Print this information
    --verbose       Enable verbose mode

Usage examples:
    $0 --toolchain gcc --target app
    $0 --toolchain gcc --target test

EOF
}

clean()
{
    if [ -d $1 ]; then
        echo "Cleaning existing directory..."
        rm -rf $1/*
        echo "Directory cleaned."
    else
        echo "Creating the directory"
        mkdir -p $1
    fi
}

# Handle empty parameter list
if [ ! $# -gt 0 ]; then
    usage
    exit 0
fi

# Handle parameters
while [ $# -gt 0 ]
do
    case $1 in
        --toolchain)
            TOOLCHAIN="$2"
            shift
            ;;
        --target)
            TARGET="$2"
            shift
            ;;
        --verbose)
            VERBOSE_MODE="VERBOSE=1"
            ;;
        --help)
            usage
            exit 0
            ;;
        *)
            echo "Unrecognized command line option $1"
            usage
            exit 1
            ;;
    esac
    shift
done

TOOLCHAIN_FILE=""
ERROR_MESSAGE=""
if [ "${TOOLCHAIN,,}" == "gcc" ]; then
    export CC=gcc
    export CXX=g++
elif [ "${TOOLCHAIN,,}" == "clang" ]; then
    export CC=clang
    export CXX=clang++
else
    ERROR_MESSAGE="No toolchain was defined! Please try again."
fi

if [ -n "${ERROR_MESSAGE}" ]; then 
    echo ${ERROR_MESSAGE}
    usage
    exit 1
fi

echo "######################################################################"
echo "Toolchain: ${TOOLCHAIN}"
echo "Target: ${TARGET}"

BUILD_DIR_PREFIX=Build/cmake_shell
BUILD_DIR_POSTFIX=${TOOLCHAIN}

# Get current directory
CMAKE_BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Current dir:" $CMAKE_BASE_DIR
echo "######################################################################"

BUILD_DIR=${CMAKE_BASE_DIR}/${BUILD_DIR_PREFIX}_${TARGET}_${BUILD_DIR_POSTFIX}

CMAKE_OPTIONS=""
TOOLCHAIN_OPTION=""

# Run CMake with resolved arguments

# Clean the build directory
echo "Setting up clean build directory."
clean ${BUILD_DIR}

CMAKE_OPTIONS="${TOOLCHAIN_OPTION} ${CMAKE_OPTIONS}"

cd ${BUILD_DIR}

echo "Cmake options: " ${CMAKE_OPTIONS}
echo "Cmake base dir: " ${CMAKE_BASE_DIR}
echo ""

# Create build environment
cmake ${CMAKE_OPTIONS} -G "Unix Makefiles" ${CMAKE_BASE_DIR}

cd ${CMAKE_BASE_DIR}
