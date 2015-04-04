# We only care for the very latest.
cmake_minimum_required(VERSION 3.2)
set(CMAKE_VERBOSE_MAKEFILE TRUE)

include(GenerateExportHeader)

set(TOPLEVEL_SOURCE_DIR ${CMAKE_SOURCE_DIR}/../src)

# This should be made into a cmake function to add both library types.
foreach(library_type STATIC SHARED)
  add_library(helloworld_${library_type} ${library_type} ${TOPLEVEL_SOURCE_DIR}/libhelloworld/helloworld.cpp ${TOPLEVEL_SOURCE_DIR}/libhelloworld/helloworld.h)
  set_target_properties(helloworld_${library_type} PROPERTIES OUTPUT_NAME helloworld)
  # The export header needs to identify a valid target, so even though both static
  # and shared variants should generate the same header file, it must be done once
  # for each target.
  generate_export_header(helloworld_${library_type}
                         BASE_NAME helloworld
                         EXPORT_FILE_NAME ${TOPLEVEL_SOURCE_DIR}/libhelloworld/helloworld_export.h)

  target_include_directories(helloworld_${library_type} PUBLIC
                             $<BUILD_INTERFACE:${TOPLEVEL_SOURCE_DIR}/libhelloworld>)
  # http://www.cmake.org/cmake/help/v3.0/module/GenerateExportHeader.html
  # "If the same sources are used to create both a shared and a static library, the
  #  uppercased symbol ${BASE_NAME}_STATIC_DEFINE should be used when building the
  #  static library"
  if(library_type STREQUAL "STATIC")
    set_target_properties(helloworld_${library_type} PROPERTIES
                          COMPILE_FLAGS -DHELLOWORLD_STATIC_DEFINE)
    # .. and the consumers of the static library need to also define this .. is there
    # no better way than this? It's verbose and brittle.
    set_target_properties(helloworld_${library_type} PROPERTIES
                          INTERFACE_COMPILE_DEFINITIONS HELLOWORLD_STATIC_DEFINE)
  endif()
endforeach(library_type)

add_executable(helloworldexe_SHARED ${TOPLEVEL_SOURCE_DIR}/main.cpp)
set_target_properties(helloworldexe_SHARED PROPERTIES OUTPUT_NAME helloworld_SHARED)
target_link_libraries(helloworldexe_SHARED helloworld_SHARED)

add_executable(helloworldexe_STATIC ${TOPLEVEL_SOURCE_DIR}/main.cpp)
set_target_properties(helloworldexe_STATIC PROPERTIES OUTPUT_NAME helloworld_STATIC)
target_link_libraries(helloworldexe_STATIC helloworld_STATIC)
