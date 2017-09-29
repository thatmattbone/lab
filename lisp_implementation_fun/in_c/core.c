#include <stdio.h>
#include <stdlib.h>
#include "core.h"


inline void 
set_car_int(Cell *cell, int value) {
  cell->car.type = INTEGER_CELL;
  cell->car.data.int_value = value;
}


inline void 
set_cdr_int(Cell *cell, int value) {
  cell->cdr.type = INTEGER_CELL;
  cell->cdr.data.int_value = value;
}


inline void 
set_car_ptr(Cell *cell, short type, void * value) {
  cell->car.type = type;
  cell->car.data.ptr_value = value;
}


inline void 
set_cdr_ptr(Cell *cell, short type, void * value) {
  cell->cdr.type = type;
  cell->cdr.data.ptr_value = value;
}


Cell *
alloc_cell() {
  Cell * new_cell = malloc(sizeof(Cell));
  set_car_ptr(new_cell, UNKOWN_CELL, NULL);
  set_cdr_ptr(new_cell, UNKOWN_CELL, NULL);
  return new_cell;
}


Cell *
alloc_int_cell(int car_value) {
  Cell *return_cell = alloc_cell();
  set_car_int(return_cell, car_value);
  return return_cell;
}


Cell *
alloc_error_cell(char *msg) {
  Cell *return_cell = alloc_cell();
  set_car_ptr(return_cell, ERROR_CELL, msg);
  return return_cell;
}

//TODO add some generic cons?


Cell * 
alloc_cond_cell(Cell *predicate, Cell *true_branch, Cell *false_branch) {
  //TODO true_branch_cell and false_branch cell can be condensed to one cell
  //TODO abstract out code in eval.c to functions used to fetch true/false/predicate so rep can be changed as needed.
  Cell *cond = alloc_cell();
  Cell *predicate_cell = alloc_cell();
  Cell *true_branch_cell = alloc_cell();
  Cell *false_branch_cell = alloc_cell();

  set_car_ptr(cond, COND_CELL, NULL);
  set_cdr_ptr(cond, LIST_CELL, predicate_cell);

  set_car_ptr(predicate_cell, LIST_CELL, predicate);
  set_cdr_ptr(predicate_cell, LIST_CELL, true_branch_cell);

  set_car_ptr(true_branch_cell, LIST_CELL, true_branch);
  set_cdr_ptr(true_branch_cell, LIST_CELL, false_branch_cell);

  set_car_ptr(false_branch_cell, LIST_CELL, false_branch);
  set_cdr_ptr(false_branch_cell, LIST_CELL, NULL);

  return cond;
}


Cell * 
alloc_equal_cell(Cell *t1, Cell *t2) {
  Cell *equal = alloc_cell();
  Cell *branches = alloc_cell();
  
  set_car_ptr(equal, EQUAL_CELL, NULL);
  set_cdr_ptr(equal, LIST_CELL, branches);

  set_car_ptr(branches, LIST_CELL, t1);
  set_cdr_ptr(branches, LIST_CELL, t2);

  return equal;
}


inline Cell * 
get_equal_first(Cell *equal) {
  Cell *branches = equal->cdr.data.ptr_value;
  return branches->car.data.ptr_value;
}


inline Cell * 
get_equal_second(Cell *equal) {
  Cell *branches = equal->cdr.data.ptr_value;
  return branches->cdr.data.ptr_value;
}


inline Atom *
car(Cell *cell) {
  return &cell->car;
}


inline Atom *
cdr(Cell *cell) {
  return &cell->cdr;
}


inline short
car_type(Cell *cell) {
  return cell->car.type;
}


inline short
cdr_type(Cell *cell) {
  return cell->cdr.type;
}



