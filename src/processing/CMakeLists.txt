function_add_library(
    NAME processing
    FILES processing.cpp
    INCLUDES_PRIVATE ${PROJECT_SOURCE_DIR}/src/hw/spi ${PROJECT_SOURCE_DIR}/src/hw/uart
)
