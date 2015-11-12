#include <stdio.h>
#include <glib.h>
#include "eval.h"
#include "core.h"

extern GHashTable* symbol_table;

void test_alloc_cell() {
  Cell *cell = alloc_cell();
  g_assert_cmpint(cell->car.type, ==, UNKOWN_CELL);
  g_assert_cmpint(cell->cdr.type, ==, UNKOWN_CELL);
}

void test_alloc_int_cell() {

  //constructing (1 . 2)
  Cell *cell = alloc_int_cell(1);

  g_assert(cell->car.type == INTEGER_CELL);

  set_cdr_int(cell, 2);

  g_assert_cmpint(cell->car.data.int_value, ==, 1);
  g_assert_cmpint(cell->cdr.data.int_value, ==, 2);
} 


void test_car_cdr() {
    
  //constructing ('a' . 'b')
  Cell *cell = alloc_cell();
    
  cell->car.type = CHAR_CELL;
  cell->cdr.type = CHAR_CELL;
  
  cell->car.data.char_value = 'a';
  cell->cdr.data.char_value = 'b';

  Atom *car_a = &cell->car;
  Atom *cdr_a = &cell->cdr;

  g_assert(car(cell) == car_a);
  g_assert(cdr(cell) == cdr_a);

  cell->cdr.type = INTEGER_CELL;
  g_assert_cmpint(car_type(cell), ==, CHAR_CELL);
  g_assert_cmpint(cdr_type(cell), ==, INTEGER_CELL);

} 

void test_set_car_cdr() {
  Cell *cell1, *cell2;
  cell1 = alloc_cell();
  cell2 = alloc_cell();
  
  set_car_int(cell1, 1);
  set_cdr_int(cell1, 2);
  g_assert_cmpint(car_type(cell1), ==, INTEGER_CELL);
  g_assert_cmpint(cell1->car.data.int_value, ==, 1);
  g_assert_cmpint(cdr_type(cell1), ==, INTEGER_CELL);
  g_assert_cmpint(cell1->cdr.data.int_value, ==, 2);

  set_car_ptr(cell1, LIST_CELL, cell2);
  g_assert_cmpint(car_type(cell1), ==, LIST_CELL);
  g_assert(cell1->car.data.ptr_value == cell2);


  set_cdr_ptr(cell2, LIST_CELL, cell1);
  g_assert_cmpint(cdr_type(cell2), ==, LIST_CELL);
  g_assert(cell2->cdr.data.ptr_value == cell1);  
}

void test_int_eval() {
  //integers should evaluate to themselves
  Cell *one = alloc_int_cell(1);
  Cell *result = eval(one);
  g_assert(one == result);
}


void test_add_eval() {
  Cell * add_op = alloc_cell();
  set_car_ptr(add_op, ADD_OP_CELL, NULL);

  Cell * result = eval(add_op);

  //test base case: (+) --> 0
  g_assert_cmpint(car_type(result), ==, INTEGER_CELL);
  g_assert_cmpint(result->car.data.int_value, ==, 0);
  

  Cell * one = alloc_int_cell(1);
  Cell * two = alloc_int_cell(2);

  set_cdr_ptr(add_op, LIST_CELL, one);
  set_cdr_ptr(one, LIST_CELL, two);

  result = eval(add_op);
  
  //(+ 1 2) --> 3
  g_assert_cmpint(car_type(result), ==, INTEGER_CELL);
  g_assert_cmpint(result->car.data.int_value, ==, 3);


  Cell * three = alloc_int_cell(3);
  set_cdr_ptr(two, LIST_CELL, three);

  result = eval(add_op);

  //(+ 1 2 3) --> 6
  g_assert_cmpint(result->car.data.int_value, ==, 6);
}

void test_sub_eval() {
  Cell * sub_op = alloc_cell();
  set_car_ptr(sub_op, SUB_OP_CELL, NULL);

  Cell * result = eval(sub_op);

  //test base case: (-) --> 0 (this isn't normal Lisp behavior)
  g_assert_cmpint(car_type(result), ==, INTEGER_CELL);
  g_assert_cmpint(result->car.data.int_value, ==, 0);

  Cell * one = alloc_int_cell(1);

  set_cdr_ptr(sub_op, LIST_CELL, one);
  result = eval(sub_op);

  //test other base case (- 1) --> -1
  g_assert_cmpint(car_type(result), ==, INTEGER_CELL);
  g_assert_cmpint(result->car.data.int_value, ==, -1);

  Cell * two = alloc_int_cell(2);
  set_cdr_ptr(one, LIST_CELL, two);

  result = eval(sub_op);
  
  //(- 1 2) --> -1
  g_assert_cmpint(car_type(result), ==, INTEGER_CELL);
  g_assert_cmpint(result->car.data.int_value, ==, -1);


  Cell * three = alloc_int_cell(3);
  set_cdr_ptr(two, LIST_CELL, three);

  result = eval(sub_op);

  //(- 1 2 3) --> -4
  g_assert_cmpint(result->car.data.int_value, ==, -4);
}


Cell * get_one_plus_two() {
  Cell * add_op = alloc_cell();
  Cell * one = alloc_int_cell(1);
  Cell * two = alloc_int_cell(2);

  /* Inner list: (+ 1 2) */
  set_car_ptr(add_op, ADD_OP_CELL, NULL);
  set_cdr_ptr(add_op, LIST_CELL, one);
  set_cdr_ptr(one, LIST_CELL, two);
 
  return add_op;
}

void test_nested_eval() {
  
  /* Inner list: (+ 1 2) */
  Cell * inner_list = get_one_plus_two();
  Cell * outer_list = alloc_cell();
  Cell * three = alloc_int_cell(3);
  Cell * four = alloc_int_cell(4);  

  Cell * result = eval(inner_list);
  
  g_assert_cmpint(car_type(result), ==, INTEGER_CELL);
  g_assert_cmpint(result->car.data.int_value, ==, 3);

  /* Outer list: (+ 3 (+ 1 2) 4) = 10 */
  Cell * branch = alloc_cell();
  set_car_ptr(outer_list, ADD_OP_CELL, NULL);
  set_cdr_ptr(outer_list, LIST_CELL, three);
  set_cdr_ptr(three, LIST_CELL, branch);
  set_car_ptr(branch, LIST_CELL, inner_list);
  set_cdr_ptr(branch, LIST_CELL, four);
  
  result = eval(outer_list);
  g_assert_cmpint(result->car.data.int_value, ==, 10);

}

void test_lambda_simple() {
  init_eval();
  Cell *lambda = alloc_cell();
  Cell *a = alloc_cell();
  Cell *code = get_one_plus_two();

  set_car_ptr(lambda, LAMBDA_CELL, NULL);
  set_cdr_ptr(lambda, LIST_CELL, a);
  set_car_ptr(a, SYMBOL_CELL, g_strdup("a"));
  set_cdr_ptr(a, LIST_CELL, code);

  eval(lambda);
  Cell *ptr = g_hash_table_lookup(symbol_table, 
                                  g_strdup("a"));

  g_assert(code == ptr);

  Cell *a2 = alloc_cell();
  set_car_ptr(a2, SYMBOL_CELL, g_strdup("a"));

  Cell *result = eval(a2);
  g_assert_cmpint(result->car.type, ==, INTEGER_CELL);  
  g_assert_cmpint(result->car.data.int_value, ==, 3);  
}


void test_cond_cell() {
  Cell *true = alloc_int_cell(1);
  Cell *false = alloc_int_cell(0);
  Cell *two = alloc_int_cell(2);
  Cell *three = alloc_int_cell(3);

  Cell *cond;
  Cell *result;

  cond = alloc_cond_cell(true, two, three);
  result = eval(cond);
  g_assert(result == two);

  cond = alloc_cond_cell(false, two, three);
  result = eval(cond);
  g_assert(result == three);

  cond = alloc_cond_cell(true, three, two);
  result = eval(cond);
  g_assert(result == three);

  cond = alloc_cond_cell(false, three, two);
  result = eval(cond);
  g_assert(result == two);
}


void test_equal_cell() {
  Cell *one = alloc_int_cell(1);
  Cell *two = alloc_int_cell(2);
  Cell *equal = alloc_equal_cell(one, one);
  Cell *non_equal = alloc_equal_cell(one, two);

  Cell *result;

  result = eval(equal);
  g_assert_cmpint(result->car.type, ==, INTEGER_CELL);  
  g_assert_cmpint(result->car.data.int_value, ==, 1);  

  result = eval(non_equal);
  g_assert_cmpint(result->car.type, ==, INTEGER_CELL);  
  g_assert_cmpint(result->car.data.int_value, ==, 0);  

}

int main(int argc, char *argv[]) {
  g_test_init(&argc, &argv, NULL);

  g_test_add_func("/core/Test Alloc Cell", test_alloc_cell);
  g_test_add_func("/core/Test Alloc Int Cell", test_alloc_int_cell);
  g_test_add_func("/core/Test car & cdr", test_car_cdr);
  g_test_add_func("/core/Test set car", test_set_car_cdr);

  g_test_add_func("/eval/Test Int Eval", test_int_eval);
  g_test_add_func("/eval/Test Add Eval", test_add_eval);
  g_test_add_func("/eval/Test Sub Eval", test_sub_eval);
  g_test_add_func("/eval/Test Nested Eval", test_nested_eval);
  g_test_add_func("/eval/Test Lambda Simple", test_lambda_simple);
  g_test_add_func("/eval/Test Cond Cell", test_cond_cell);
  g_test_add_func("/eval/Test Equal Cell", test_equal_cell);

 return g_test_run();

}
