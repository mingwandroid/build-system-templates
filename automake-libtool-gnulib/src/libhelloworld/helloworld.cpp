#include <stdio.h>
#include <unistd.h>
#include "helloworld.h"

HELLOWORLD_EXPORT void helloworld() {
  char name[256] = { '\0' };
  int result = gethostname(name, sizeof(name)-1);
  printf("Hello World! %s\n", name);
}
