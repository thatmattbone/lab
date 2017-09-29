#include <string.h>
#include <stdio.h>

int main(void) {
  char into[256];

  int five = 5;

  sprintf(into, "hello %d", five);

  print(into);
  printf("\n");
}
