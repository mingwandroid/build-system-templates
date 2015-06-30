
#ifndef HELLOWORLD_EXPORT_H
#define HELLOWORLD_EXPORT_H

#ifdef HELLOWORLD_STATIC_DEFINE
#  define HELLOWORLD_EXPORT
#  define HELLOWORLD_NO_EXPORT
#else
#  ifndef HELLOWORLD_EXPORT
#    ifdef helloworld_SHARED_EXPORTS
        /* We are building this library */
#      define HELLOWORLD_EXPORT __declspec(dllexport)
#    else
        /* We are using this library */
#      define HELLOWORLD_EXPORT __declspec(dllimport)
#    endif
#  endif

#  ifndef HELLOWORLD_NO_EXPORT
#    define HELLOWORLD_NO_EXPORT 
#  endif
#endif

#ifndef HELLOWORLD_DEPRECATED
#  define HELLOWORLD_DEPRECATED __attribute__ ((__deprecated__))
#endif

#ifndef HELLOWORLD_DEPRECATED_EXPORT
#  define HELLOWORLD_DEPRECATED_EXPORT HELLOWORLD_EXPORT HELLOWORLD_DEPRECATED
#endif

#ifndef HELLOWORLD_DEPRECATED_NO_EXPORT
#  define HELLOWORLD_DEPRECATED_NO_EXPORT HELLOWORLD_NO_EXPORT HELLOWORLD_DEPRECATED
#endif

#define DEFINE_NO_DEPRECATED 0
#if DEFINE_NO_DEPRECATED
# define HELLOWORLD_NO_DEPRECATED
#endif

#endif
