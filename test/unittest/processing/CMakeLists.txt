#
# add_unit_test(<target> <sources>...)
#
#  Adds a Google Mock based test executable, <target>, built from <sources> and
#  adds the test so that CTest will run it. Both the executable and the test
#  will be named <target>.
#
function(add_unit_test testSuite)
  add_executable(${testSuite} "${testSuite}.cpp" ${ARGN})
  if (THREADS_HAVE_PTHREAD_ARG)
    target_compile_options(PUBLIC ${testSuite} "-pthread")
  endif ()
  target_compile_options(${testSuite} PUBLIC -DUNIT_TEST -D__BUILD_NAME__="googletestprocessing")
  target_link_libraries(${testSuite} ${GMOCK_LIBRARIES})
  if (CMAKE_THREAD_LIBS_INIT)
    target_link_libraries(${testSuite} "${CMAKE_THREAD_LIBS_INIT}")
  endif ()
  target_include_directories(${testSuite}
    PUBLIC
    ${PROJECT_SOURCE_DIR}/Include
    ${PROJECT_SOURCE_DIR}/src/processing
    ${PROJECT_SOURCE_DIR}/src/ui
    ${PROJECT_SOURCE_DIR}/test
    ${PROJECT_SOURCE_DIR}/test/unit_test/stubs)
  add_test(${testSuite} ${testSuite})
endfunction()

add_unit_test(TestProcessing
  ${PROJECT_SOURCE_DIR}/src/processing/processing.cpp
)
