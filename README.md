# build-system-templates
Templates projects for various build systems: autotools{,+gnulib}, CMake, Qbs, GYP etc etc

# ramblings:
Is it possible to avoid the import library cost with autotools + libtool when building both
static and shared libraries at the same time?

mingw-w64-libsystre seems to avoid it.

The requirements of CMake with Visual Studio are the most onerous and setting up an export
header as CMake suggests (and including it from both from each library and each consumers
of each library pushes these requirements onto the other build systems.

http://www.cmake.org/cmake/help/v3.3/module/GenerateExportHeader.html

Building a static library:
Define LIBHELLOWORLD_BUILD

Building a shared library:
Define helloworld_SHARED_EXPORTS

Building something that links to a static library:
Define LIBHELLOWORLD_BUILD

Building something that links to a shared library:
<nothing>
