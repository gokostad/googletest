# there are some bugs in building in windows with msys2 gmock with pthread
if(MSYS OR CYGWIN OR MINGW OR MSYS2)
    set (gtest_disable_pthreads on)
else()
    find_package(Threads REQUIRED)
endif()

if (CMAKE_VERSION VERSION_LESS 3.2)
    set(UPDATE_DISCONNECTED_IF_AVAILABLE "")
else()
    set(UPDATE_DISCONNECTED_IF_AVAILABLE "UPDATE_DISCONNECTED 1")
endif()

# Define compile flags for GoogleMock. Disable extra warning flags.
# Save compiler flags, set new ones, restore old ones at the end
set(SAVED_CMAKE_C_FLAGS ${CMAKE_C_FLAGS})
set(SAVED_CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS})

set(GMOCK_DISABLED_FLAGS_REGEX "-W[a-z-]*")
string(REGEX REPLACE "${GMOCK_DISABLED_FLAGS_REGEX}" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REGEX REPLACE "${GMOCK_DISABLED_FLAGS_REGEX}" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

include(${PROJECT_SOURCE_DIR}/cmake/DownloadProject.cmake)
download_project(
  PROJ    googletest
  GIT_REPOSITORY      https://github.com/google/googletest.git
  GIT_TAG             master
  ${UPDATE_DISCONNECTED_IF_AVAILABLE}
  #CMAKE_ARGS ${GMOCK_CMAKE_ARGS}
)

link_directories("${gmock_BINARY_DIR}")
set(GMOCK_LIBRARIES gmock gmock_main)

# Prevent GoogleTest from overriding our compiler/linker options
# when building with Visual Studio
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})

# restore old flags
set(CMAKE_C_FLAGS ${SAVED_CMAKE_C_FLAGS})
set(CMAKE_CXX_FLAGS ${SAVED_CMAKE_CXX_FLAGS})

include_directories(${gtest_SOURCE_DIR}/include  ${gmock_SOURCE_DIR}/include)

#add_subdirectory(stubs)
add_subdirectory(processing)

foreach(testSuite ${TEST_SUITES})
  add_executable(${testSuite} "${testSuite}.cpp")
  if(THREADS_HAVE_PTHREAD_ARG)
    target_compile_options(PUBLIC ${testSuite} "-pthread")
  endif()
  target_link_libraries(${testSuite} ${GMOCK_LIBRARIES})
  if(CMAKE_THREAD_LIBS_INIT)
    target_link_libraries(${testSuite} "${CMAKE_THREAD_LIBS_INIT}")
  endif()
  add_test(${testSuite} ${testSuite})
endforeach(testSuite)

#if(NOT CMAKE_SYSTEM_NAME STREQUAL Windows)
#  setup_target_for_coverage(coverage_html ctest coverage)
#  setup_target_for_coverage_cobertura(coverage ctest coverage)
#endif()

