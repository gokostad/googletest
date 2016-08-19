# function can be called with following syntax
# function_add_library(option1 option2 NAME libA FILES file1.c file2.c INCLUDES inc1.h inc2.h INCLUDES_PRIVATE incp1.h incp2.have
#                      DEPENDENCIES dep1 dep2 PUBLIC_COMPILE_DEFINITIONS cd1 cd2 cd3 PRIVATE_COMPILE_DEFINITIONS pcd1)
# option1 and option2 are used as example and are not used in function
function(function_add_library)
    # option NAME in calling this function will have only one possible value
    set(oneValueArgs NAME)
    set(multiValueArgs FILES INCLUDES INCLUDES_PRIVATE DEPENDENCIES PUBLIC_COMPILE_DEFINITIONS PRIVATE_COMPILE_DEFINITIONS)
    cmake_parse_arguments(function_add_library "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    # lets see how what NAME is passed as argument
    if ("${function_add_library_NAME}" STREQUAL "")
        message(FATAL_ERROR "NAME parameter is required")
    endif()

    add_library(${function_add_library_NAME} EXCLUDE_FROM_ALL ${function_add_library_FILES})
    
    target_include_directories(${function_add_library_NAME} PUBLIC ${function_add_library_INCLUDES})
    target_include_directories(${function_add_library_NAME} PRIVATE ${function_add_library_INCLUDES_PRIVATE})
    target_compile_definitions(${function_add_library_NAME} PUBLIC ${function_add_library_PUBLIC_COMPILE_DEFINITIONS})
    target_compile_definitions(${function_add_library_NAME} PRIVATE ${function_add_library_PRIVATE_COMPILE_DEFINITIONS})
    target_link_libraries(${function_add_library_NAME} PUBLIC ${function_add_library_DEPENDENCIES})
endfunction()

# function can be called with following syntax
# function_add_library(option1 option2 NAME libA INCLUDES inc1.h inc2.h DEPENDENCIES dep1 dep2)
# option1 and option2 are used as example and are not used in function
function(function_add_interface_library)
    set(oneValueArgs NAME)
    set(multiValueArgs INCLUDES DEPENDENCIES)
    cmake_parse_arguments(function_add_interface_library "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    if ("${function_add_interface_library_NAME}" STREQUAL "")
        message(FATAL_ERROR "NAME parameter is required")
    endif()
    
    add_library(${function_add_interface_library_NAME} INTERFACE)
    
    target_include_directories(${function_add_interface_library_NAME} INTERFACE
        ${function_add_interface_library_INCLUDES})
    target_link_libraries(${function_add_interface_library_NAME} INTERFACE
        ${function_add_interface_library_DEPENDENCIES})
endfunction()
