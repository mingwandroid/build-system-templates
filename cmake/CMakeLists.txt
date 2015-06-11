# We only care for the very latest.
cmake_minimum_required(VERSION 3.2)
set(CMAKE_VERBOSE_MAKEFILE TRUE)

include(GenerateExportHeader)

set(TOPLEVEL_SOURCE_DIR ${CMAKE_SOURCE_DIR}/../src)

if(NOT DEFINED BUILD_STATIC_EXES)
  set(BUILD_STATIC_EXES ${BUILD_STATIC_LIBS})
endif()

if(NOT DEFINED BUILD_SHARED_EXES)
  set(BUILD_SHARED_EXES ${BUILD_SHARED_LIBS})
endif()

if(BUILD_STATIC_EXES)
  set(CMAKE_C_LINK_FLAGS "${CMAKE_EXE_LINK_STATIC_C_FLAGS}")
  set(CMAKE_CXX_LINK_FLAGS "${CMAKE_EXE_LINK_STATIC_CXX_FLAGS}")
endif()

if(BUILD_STATIC_LIBS)
  list(APPEND LIB_VARIANTS STATIC)
endif()
if(BUILD_SHARED_LIBS)
  list(APPEND LIB_VARIANTS SHARED)
endif()

if(BUILD_STATIC_EXES)
  list(APPEND EXE_VARIANTS STATIC)
endif()
if(BUILD_SHARED_EXES)
  list(APPEND EXE_VARIANTS SHARED)
endif()

if(BUILD_STATIC_EXES AND BUILD_SHARED_EXES)
  set(STATIC_EXE_SUFFIX _STATIC)
  set(SHARED_EXE_SUFFIX _SHARED)
endif()

# Should this be made into a cmake function to add both library types?
foreach(library_type ${LIB_VARIANTS})
  add_library(helloworld_${library_type} ${library_type} ${TOPLEVEL_SOURCE_DIR}/libhelloworld/helloworld.cpp ${TOPLEVEL_SOURCE_DIR}/libhelloworld/helloworld.h)
  set_target_properties(helloworld_${library_type} PROPERTIES OUTPUT_NAME helloworld)
  # The export header needs to identify a valid target, so even though both static
  # and shared variants should generate the same header file, it must be done once
  # for each target. STATIC_DEFINE LIBHELLOWORLD_BUILD is an attempt to retain compat.
  # with Autotools (see http://www.hep.by/gnu/libtool/Windows-DLLs.html)
  generate_export_header(helloworld_${library_type}
                         BASE_NAME helloworld
                         STATIC_DEFINE LIBHELLOWORLD_BUILD
                         EXPORT_FILE_NAME ${TOPLEVEL_SOURCE_DIR}/libhelloworld/helloworld_export.h)

  target_include_directories(helloworld_${library_type} PUBLIC
                             $<BUILD_INTERFACE:${TOPLEVEL_SOURCE_DIR}/libhelloworld>)
  # http://www.cmake.org/cmake/help/v3.2/module/GenerateExportHeader.html
  # "If the same sources are used to create both a shared and a static library, the
  #  uppercased symbol ${BASE_NAME}_STATIC_DEFINE should be used when building the
  #  static library"
  if(library_type STREQUAL "STATIC")
    set_target_properties(helloworld_${library_type} PROPERTIES
                          COMPILE_FLAGS -DLIBHELLOWORLD_BUILD)
    # .. and the consumers of the static library need to also define this .. is there
    # no better way than this? It's verbose and brittle.
    set_target_properties(helloworld_${library_type} PROPERTIES
                          INTERFACE_COMPILE_DEFINITIONS LIBHELLOWORLD_BUILD)
  endif()
endforeach(library_type)

foreach(executable_type ${EXE_VARIANTS})
  add_executable(helloworldexe_${executable_type} ${TOPLEVEL_SOURCE_DIR}/main.cpp)
  set_target_properties(helloworldexe_${executable_type} PROPERTIES OUTPUT_NAME helloworld${${executable_type}_EXE_SUFFIX})
  target_link_libraries(helloworldexe_${executable_type} helloworld_${executable_type})
endforeach(executable_type)
