%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <glib.h>
#include "core.h"
#include "eval.h"
#include "printer.h"

Cell *head;
Cell *tail;

extern char* yytext;

void *
init() {
  head = alloc_cell();
  tail = head;
}

void *
inner_eval() {
  printf("calling inner_eval\n");

  Cell * eval_this = (Cell *) head->cdr.data.ptr_value;
  Cell * result =  eval(eval_this);
  pretty_print(result);
  //TODO free resources!
  init();
}

void *
push_integer(int i) {
  printf("pushing %d\n", i);

  Cell *new_int = alloc_int_cell(i);
  
  tail->cdr.type = LIST_CELL;
  tail->cdr.data.ptr_value = new_int;

  tail = new_int;
}

void * 
push_add_op() {
  printf("pushing add_op\n");

  Cell * add_op = alloc_cell();
  add_op->car.type = ADD_OP_CELL;

  tail->cdr.type = LIST_CELL;
  tail->cdr.data.ptr_value = add_op;

  tail = add_op;
}

void * 
push_sub_op() {
  printf("pushing sub_op\n");

  Cell * sub_op = alloc_cell();
  sub_op->car.type = SUB_OP_CELL;

  tail->cdr.type = LIST_CELL;
  tail->cdr.data.ptr_value = sub_op;

  tail = sub_op;
}

void *
push_lambda() {
  printf("pushing lambda\n");
  Cell *lambda = alloc_cell();
  set_car_ptr(lambda, LAMBDA_CELL, NULL);

  tail->cdr.type = LIST_CELL;
  tail->cdr.data.ptr_value = lambda;

  tail = lambda;
}

void *
push_symbol() {
  printf("pushing symbol: %s\n", yytext);
  Cell *symbol = alloc_cell();
  set_car_ptr(symbol, SYMBOL_CELL, g_strdup(yytext));

  tail->cdr.type = LIST_CELL;
  tail->cdr.data.ptr_value = symbol;

  tail = symbol;

}

%}

%token	INTEGER DOUBLE
%token	PLUS	MINUS	MULT	DIV
%token	LPAREN	RPAREN
%token LAMBDA SYMBOL
%token COND

%start Lists
%%

Atom:
      PLUS { push_add_op(); }
    | MINUS { push_sub_op(); }
    | MULT
    | DIV
    | INTEGER { push_integer(yylval); }
    | DOUBLE
    | LAMBDA  { push_lambda(); }
    | SYMBOL  { push_symbol(); }
    ;

Atoms:
     Atom
   | Atoms Atom
   ;

Sexp:
      Atom
    | LPAREN RPAREN 
    | LPAREN Atoms RPAREN
    | LPAREN Sexp RPAREN
    | LPAREN Atoms Sexp RPAREN
    | LPAREN Atoms Sexp Atoms RPAREN
    | LPAREN Sexp Atoms RPAREN
    ;
 
Lists:
      Sexp {inner_eval(); printf("sexp\n");}
    | Lists Sexp {inner_eval(); printf("lists sexp\n");}
    ;


/*{inner_eval();}
Input:
	  Empty 
	| Input Line
	;

Line:
	  END
	| Expression END		{ printf("Result: %f\n",$1); }
	;

Expression:
	  NUMBER			{ $$=$1; }
	| Expression PLUS Expression	{ $$=$1+$3; }
	| Expression MINUS Expression	{ $$=$1-$3; }
	| Expression TIMES Expression	{ $$=$1*$3; }
	| Expression DIVIDE Expression	{ $$=$1/$3; }
	| MINUS Expression %prec NEG	{ $$=-$2; }
	| Expression POWER Expression	{ $$=pow($1,$3); }
	| LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS	{ $$=$2; }
	;
*/
%%

int yyerror(char *s) {
  printf("something went wrong: %s\n",s);
}

int main(void) {
  init_eval();
  init();
  yyparse();
}
