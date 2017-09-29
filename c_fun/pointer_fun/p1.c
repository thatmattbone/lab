#include <stdio.h>

int main(void) {
  int x = 1;
  int y = 2;
  int z[10];

  int *p;

  p = &x;
  *p = 5;

  y = *p;

  printf("x: %d\n", x);
  printf("y: %d\n", y);

  z[0] = 1;
  z[1] = 2;

  int *pp;
  pp = z;

  printf("z[0]: %d\n", z[0]);
  printf("z[1]: %d\n", z[1]);  

  printf("pp0: %d\n", *pp);
  pp = pp + 1;
  printf("pp1: %d\n", *pp);  


}
