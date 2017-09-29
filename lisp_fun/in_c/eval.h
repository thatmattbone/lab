#ifndef EVAL_H
#define EVAL_H

#include "core.h"

void 
init_eval();

Cell * 
eval_add_op(Cell *head);

Cell * 
eval_sub_op(Cell *head);

Cell * 
eval_lambda(Cell *head);

Cell *
eval_symbol(Cell *head);

Cell *
eval_cond(Cell *head);

Cell * 
eval_equal(Cell *head);

Cell * 
eval(Cell *head);

#endif
