include(${PROJECT_SOURCE_DIR}/cmake/download_googlemock.cmake)

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

