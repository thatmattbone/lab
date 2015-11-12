
#include <stdio.h>
#include "core.h"
#include "printer.h"

void * 
pretty_print(Cell *head) {

  if(head == NULL) {
    printf("pp> NULL\n");
  } else if(head->car.type == ERROR_CELL) {
    printf("pp> ERROR: %s", (char *) head->car.data.ptr_value);
  } else if(head->car.type == INTEGER_CELL) {
    printf("pp> %d\n", head->car.data.int_value);
  } else {
    printf("Unkown type in pretty print.\n");
  }
}
