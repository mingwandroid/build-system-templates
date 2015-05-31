bin_PROGRAMS = helloworld
AM_CXXFLAGS = $(HELLOWORLD_CFLAGS)

# libm is a dummy library on mingw-w64, so
# using it to show an example of _la_LIBADD
lib_LTLIBRARIES = libhelloworld.la
libhelloworld_la_LIBADD = -lm
libhelloworld_la_SOURCES = libhelloworld/helloworld.cpp libhelloworld/helloworld.h
libhelloworld_la_LDFLAGS = -no-undefined $(GETHOSTNAME_LIB) $(LIBSOCKET)

helloworld_SOURCES = main.cpp
helloworld_LDADD = libhelloworld.la
