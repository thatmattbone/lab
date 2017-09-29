#include <stdio.h>
#include <glib.h>

#define ALLOCSIZE 10000

static char allocbuf[ALLOCSIZE];
static char *allocp = allocbuf;

char *alloc(int n) {
  if(allocbuf + ALLOCSIZE - allocp >=  n) { //good, we have enough memory
    allocp += n;
    return allocp - n;
  } else { //no, we don't have enough memory
    return 0;
  }
}


void afree(char *p) {
  //memset?
  if(p >= allocbuf && p < allocbuf + ALLOCSIZE) {
    allocp = p;
  }
}

void test_test() {
  g_assert_cmpint(4, ==, 4);
}


int main(int argc, char *argv[]) {
  g_test_init(&argc, &argv, NULL);

  g_test_add_func("/core/Test Test", test_test);

 return g_test_run();

}
