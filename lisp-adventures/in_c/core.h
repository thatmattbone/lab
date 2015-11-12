#ifndef CORE_H

#define CORE_H

#define INTEGER_CELL 1 //AtomData is integer
#define DOUBLE_CELL  2 //AtomData is double
#define CHAR_CELL    3 //AtomData is char 
#define STRING_CELL  4 //AtomData is string pointer
#define LIST_CELL    5 //AtomData is pointer to a cons cell
#define SYMBOL_CELL  10 //AtomData is a symbol pointer

#define ADD_OP_CELL  11 //AtomData is the add operation
#define SUB_OP_CELL  12 //AtomData is the sub operation
#define LAMBDA_CELL  13 //AtomData is a lambda
#define COND_CELL    14 //AtomData is a cond
#define EQUAL_CELL   15 //AtomData is a lambda

#define UNKOWN_CELL  20 //AtomData is unkown (something has gone wrong)
#define ERROR_CELL   21 //AtomData is an error pointer

typedef union atom_data {
  int    int_value;
  double double_value;
  char   char_value;
  void   *ptr_value;
} AtomData;

typedef struct atom {
  short type;
  AtomData data;
} Atom;

typedef struct cell {
  Atom car;
  Atom cdr;
} Cell;

Atom
int_atom(int i);

Cell * 
alloc_cell();

Cell * 
alloc_int_cell(int car_value);

Cell *
alloc_error_cell(char *msg);

Cell * 
alloc_cond_cell(Cell *predicate, Cell *true_branch, Cell *false_branch);

Cell * 
alloc_equal_cell(Cell *t1, Cell *t2);

inline Cell * 
get_equal_first(Cell *equal);

inline Cell * 
get_equal_second(Cell *equal);

void 
set_car_int(Cell *cell, int value);

void 
set_cdr_int(Cell *cell, int value);

void 
set_car_ptr(Cell *cell, short type, void *value);

void 
set_cdr_ptr(Cell *cell, short type, void *value);

Atom *
car(Cell *);

Atom *
cdr(Cell *);

short
car_type(Cell * cell);

short
cdr_type(Cell * cell);

void free_list();

#endif
