#include <stdio.h>

int add_one(int a) {
  return a + 1;
}


int add_two(int a) {
  return add_one(add_one(a));
}


int main(void) {
  printf("1 + 1 = %d\n", add_one(1));
  printf("1 + 2 = %d\n", add_two(1));
}
