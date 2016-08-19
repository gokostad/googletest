# default directory for installing should be /usr/share/<component>
# override via command line is possible, to start using this on windows
# add a linux/windows switch
if("${INSTALL_DIR}" STREQUAL "")
  set(INSTALL_DIR "/usr/share/${CMAKE_PROJECT_NAME}")
endif()