add_custom_target(
  cppcheck
  COMMAND cppcheck --quiet --enable=information,warning,performance,portability,missingInclude ${PROJECT_SOURCE_DIR}/src ${PROJECT_SOURCE_DIR}/Include)
