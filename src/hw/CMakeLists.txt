add_subdirectory(spi)
add_subdirectory(uart)

function_add_interface_library(
    NAME drivers
    DEPENDENCIES
        uartdriver
)
