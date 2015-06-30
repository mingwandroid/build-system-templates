{
  'targets': [ {
     'target_name': 'helloworld_static',
    'type': 'executable', 
    'sources': [ '../src/main.cpp' ],
    'dependencies': [ 'libhelloworld_static' ]
  }, {
    'target_name': 'libhelloworld_static',
    'type': 'static_library',
    'defines': [ 'LIBHELLOWORLD_BUILD' ],
    'direct_dependent_settings': {
      'defines': [ 'LIBHELLOWORLD_BUILD' ],
    },
    'sources': [ '../src/libhelloworld/helloworld.cpp',
                 '../src/libhelloworld/helloworld.h' ],
  }, {
     'target_name': 'helloworld_shared',
    'type': 'executable', 
    'sources': [ '../src/main.cpp' ],
    'dependencies': [ 'libhelloworld_shared' ]
  }, {
    'target_name': 'libhelloworld_shared',
    'type': 'shared_library',
    'defines': [ 'helloworld_SHARED_EXPORTS' ],
    'sources': [ '../src/libhelloworld/helloworld.cpp',
                 '../src/libhelloworld/helloworld.h' ],
  }, ]
}
