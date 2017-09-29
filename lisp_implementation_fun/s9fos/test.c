#include <stdio.h>

int main(void) {
  //char *msg = "hello" ;
  char msg = getc(stdin);
  printf("%c", msg);
  //fwrite(msg, 1, 5, stdout);
}
