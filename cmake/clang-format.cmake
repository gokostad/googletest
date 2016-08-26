file(GLOB_RECURSE SOURCE_FILES src/*.c)
file(GLOB_RECURSE HEADER_FILES Include/*.h)
list(APPEND ALL_FILES ${SOURCE_FILES} ${HEADER_FILES})

add_custom_target(
  clangformat
  COMMAND clang-format -i ${ALL_FILES})
