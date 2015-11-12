#include <stdlib.h>
#include <stdio.h>
#include <glib.h>
#include "core.h"
#include "eval.h"

GHashTable* symbol_table;

void
init_eval() {
  symbol_table = g_hash_table_new(g_str_hash, 
                                  g_str_equal);
}


Cell * 
eval_add_op(Cell *head) {
  Cell *operand = head;
  operand = operand->cdr.data.ptr_value;

  int sum = 0;
  while(1) {
    if(operand == NULL) {
      /* add-op was called with no args, break to return a sum of 0 */
      break; 
    }

    Cell * result = eval(operand);

    if(car_type(result) == INTEGER_CELL) {
      sum += result->car.data.int_value;
    } else if(car_type(result) == ERROR_CELL) {
      //propogate error up
      return result;
    } else {
      return alloc_error_cell(g_strdup_printf("eval(add_op) failed. Nested operations must return integers.\n"));
    }


    if(cdr_type(operand) == LIST_CELL) {
      operand = operand->cdr.data.ptr_value;
    } else { /* TODO: Change the end of a list to an explicit value?  And test for this value? */
      break;
    }
            
  }       
  return alloc_int_cell(sum);
}


Cell * 
eval_sub_op(Cell *head) {
  Cell *operand = head;
  operand = operand->cdr.data.ptr_value;

  if(operand == NULL) {
    /* sub-op was called with no args, break to return a difference of 0 */
    return alloc_int_cell(0);
  }
  //TODO implement in terms of addition

  int difference = 0;
  int runs = 0;
  while(1) {

    Cell * result = eval(operand);

    if(car_type(result) == INTEGER_CELL) {
      if(runs == 0) {
        difference = (-1) * result->car.data.int_value;
        runs++;
      } else {
        difference += result->car.data.int_value;
        runs++;
      }
    } else if(car_type(result) == ERROR_CELL) {
      //propogate error up
      return result;
    } else {
      return alloc_error_cell(g_strdup_printf("eval(add_op) failed. Nested operations must return integers.\n"));
    }

    if(cdr_type(operand) == LIST_CELL) {
      operand = operand->cdr.data.ptr_value;
    } else { /* TODO: Change the end of a list to an explicit value?  And test for this value? */
      break;
    }

  }
  if(runs>1) {
    return alloc_int_cell((-1) * difference);
  } else {
    return alloc_int_cell(difference);
  }
}


Cell *
eval_lambda(Cell *head) {
  if(cdr_type(head) == LIST_CELL) {
    Cell *symbol = head->cdr.data.ptr_value;
      
    //the symbol cell points to some code
    if(car_type(symbol) == SYMBOL_CELL && cdr_type(symbol) == LIST_CELL) {

      g_hash_table_insert(symbol_table, 
                          symbol->car.data.ptr_value, 
                          symbol->cdr.data.ptr_value);
      return NULL;
    } else {
      return alloc_error_cell(g_strdup_printf("symbol must be followed by list\n"));
    }
  } else {
    return alloc_error_cell(g_strdup_printf("lambda must be followed by symbol\n"));
  }
}


Cell *
eval_symbol(Cell *head) {

  //look the symbol up
  Cell *func = g_hash_table_lookup(symbol_table, 
                                   head->car.data.ptr_value);
  if(func == NULL) {
    return alloc_error_cell(g_strdup_printf("symbol not found: %s\n", (char *) head->car.data.ptr_value));
  } else {
    //run eval on it.
    return eval(func);
  }
}


Cell * 
eval_cond(Cell *head) {

  Cell *predicate_cell = head->cdr.data.ptr_value;
  Cell *true_branch_cell =  predicate_cell->cdr.data.ptr_value;
  Cell *false_branch_cell =  true_branch_cell->cdr.data.ptr_value;

  Cell *result = eval(predicate_cell->car.data.ptr_value);
  
  if(result->car.data.int_value == 0) {
    //return eval of false branch
    return eval(false_branch_cell->car.data.ptr_value);
  } else {
    //return eval of true branch
    return eval(true_branch_cell->car.data.ptr_value);
  }

  return alloc_error_cell(g_strdup_printf("not yet implemented\n"));
}


Cell * 
eval_equal(Cell *head) {
  Cell *result1 = eval(get_equal_first(head));
  Cell *result2 = eval(get_equal_second(head));

  if(result1->car.data.int_value == result2->car.data.int_value) {
    return alloc_int_cell(1);
  } else {
    return alloc_int_cell(0);
  }
}


Cell * 
eval(Cell *head) {

  if(head == NULL) {
    return alloc_error_cell(g_strdup_printf("eval() failed. Cannot evaluate a null object.\n"));
  }

  int type = car_type(head);
  switch(type) {
    case INTEGER_CELL:
      return head;
      
    case LIST_CELL:
      //TODO is this a hack?
      return eval(head->car.data.ptr_value);

    case ADD_OP_CELL:
      return eval_add_op(head);

    case SUB_OP_CELL:
      return eval_sub_op(head);

    case LAMBDA_CELL:
      return eval_lambda(head);
   
    case SYMBOL_CELL:
      return eval_symbol(head);

    case COND_CELL:
      return eval_cond(head);

    case EQUAL_CELL:
      return eval_equal(head);

  }  

  return alloc_error_cell(g_strdup_printf("eval() failed. Cell type %d not matched.\n", car_type(head)));
}

