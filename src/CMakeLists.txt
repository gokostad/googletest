set(APPLICATION_SOURCES
    main.cpp
)
message(STATUS "I am adding executable here")
add_executable(${PROJECT_NAME} ${APPLICATION_SOURCES})
#target_link_libraries(${PROJECT_NAME} PUBLIC drivers)

# generate .map file
#target_link_libraries(${PROJECT_NAME} PUBLIC "--map ${CMAKE_CURRENT_BINARY_DIR}/map_googletest")

#install(TARGETS ${PROJECT_NAME} DESTINATION ${INSTALL_DIR})

add_subdirectory(hw)
add_subdirectory(processing)
add_subdirectory(ui)