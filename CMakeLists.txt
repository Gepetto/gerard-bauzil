#
# Copyright CNRS
#
# Author: Olivier Stasse
#
cmake_minimum_required(VERSION 3.10)

set(PROJECT_NAME gerard_bauzil)
set(PROJECT_DESCRIPTION "Gerard Bauzil data files")
set(PROJECT_URL "https://github.com/Gepetto/gerard-bauzil")

# Check if the submodule cmake have been initialized
set(JRL_CMAKE_MODULES "${CMAKE_CURRENT_LIST_DIR}/cmake")
if(EXISTS "${JRL_CMAKE_MODULES}/base.cmake")
  message(STATUS "JRL cmakemodules found in 'cmake/' git submodule")
else()
  find_package(jrl-cmakemodules QUIET CONFIG)
  if(jrl-cmakemodules_FOUND)
    get_property(
      JRL_CMAKE_MODULES
      TARGET jrl-cmakemodules::jrl-cmakemodules
      PROPERTY INTERFACE_INCLUDE_DIRECTORIES)
    message(STATUS "JRL cmakemodules found on system at ${JRL_CMAKE_MODULES}")
  elseif(${CMAKE_VERSION} VERSION_LESS "3.14.0")
    message(
      FATAL_ERROR
        "\nCan't find jrl-cmakemodules. Please either:\n"
        "  - use git submodule: 'git submodule update --init'\n"
        "  - or install https://github.com/jrl-umi3218/jrl-cmakemodules\n"
        "  - or upgrade your CMake version to >= 3.14 to allow automatic fetching\n"
    )
  else()
    message(STATUS "JRL cmakemodules not found. Let's fetch it.")
    include(FetchContent)
    FetchContent_Declare(
      "jrl-cmakemodules"
      GIT_REPOSITORY "https://github.com/jrl-umi3218/jrl-cmakemodules.git")
    FetchContent_MakeAvailable("jrl-cmakemodules")
    FetchContent_GetProperties("jrl-cmakemodules" SOURCE_DIR JRL_CMAKE_MODULES)
  endif()
endif()

include("${JRL_CMAKE_MODULES}/base.cmake")

compute_project_args(PROJECT_ARGS)
project(${PROJECT_NAME} ${PROJECT_ARGS})

add_subdirectory(data)

config_files(urdf/cobblestone.urdf)

install(
  DIRECTORY urdf/
  DESTINATION share/${PROJECT_NAME}/urdf
  FILE_PERMISSIONS OWNER_READ GROUP_READ WORLD_READ OWNER_WRITE
  PATTERN "*.urdf")
install(FILES ${CMAKE_BINARY_DIR}/urdf/cobblestone.urdf
        DESTINATION share/${PROJECT_NAME}/urdf)
install(
  DIRECTORY xacro srdf launch meshes maps
  DESTINATION share/${PROJECT_NAME}
  FILE_PERMISSIONS OWNER_READ GROUP_READ WORLD_READ OWNER_WRITE)
install(FILES package.xml DESTINATION share/${PROJECT_NAME}/)

setup_project_finalize()
