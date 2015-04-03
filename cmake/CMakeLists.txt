add_library(helloworld_STATIC STATIC src/helloworld.cpp src/helloworld.h)
add_library(helloworld_SHARED SHARED src/helloworld.cpp src/helloworld.h)
set_target_properties(helloworld_STATIC PROPERTIES OUTPUT_NAME helloworld)
set_target_properties(helloworld_SHARED PROPERTIES OUTPUT_NAME helloworld)

add_executable(helloworldexe WIN32 src/main.cpp)
set_target_properties(helloworldexe PROPERTIES OUTPUT_NAME helloworld)

target_link_libraries(helloworldexe helloworld_SHARED)
