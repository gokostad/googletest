add_subdirectory(hw)
add_subdirectory(processing)
add_subdirectory(ui)

set(APPLICATION_INCLUDES
    ui
    processing
)

set(APPLICATION_SOURCES
    main.cpp
)

add_executable(${PROJECT_NAME} ${APPLICATION_SOURCES})
target_include_directories(${PROJECT_NAME} PUBLIC ${APPLICATION_INCLUDES})
target_link_libraries(${PROJECT_NAME} PUBLIC drivers ui processing)

# generate .map file
#target_link_libraries(${PROJECT_NAME} PUBLIC "--map ${CMAKE_CURRENT_BINARY_DIR}/map_googletest")

install(TARGETS ${PROJECT_NAME} DESTINATION ${INSTALL_DIR})
