// Should the library be installed though? For shared, yes, probably.
// Regardless of whether libhelloworld is installed in prefix or not,
// during the build we need to include its header from the src tree.
#include "libhelloworld/helloworld.h"

int main(int argc, char const* argv[]) {
  helloworld();
  return 0;
}
