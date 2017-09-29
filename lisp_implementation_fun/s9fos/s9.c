/**
 * Scheme 9 from Empty Space
 *
 * Originally by Nils M Holm
 * A riff by Matt Bone
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <limits.h>

#include "gc.h"

#define nl() pr("\n");

int error(char *msg, int expr);

void pr(char *s) {
  printf("%s", s);
}

int error(char *msg, int expr) {
  int oport;
  if(Error_flag) return UNSPECIFIC;
  Error_flag = 1;
  printf("error: %s", msg);
  if(expr != NOEXPR) {
    pr(": ");
    print(expr);
  }
  nl();
  if (Quiet_mode) exit(1);
  return UNSPECIFIC;
}

int fatal(char *msg) {
  printf("fatal ");
  error(msg, NOEXPR);
  exit(2);
}

int find_symbol(char *s) {
  return NIL;
}

#define separator(c) \
  ((c)==' '  || (c)=='\t' || (c)=='\n' || \
   (c)=='\r' || (c)=='('  || (c)==')'  || \
   (c)==';'  || (c)=='#'  || (c)=='\'' || \
   (c)=='`'  || (c)==','  || (c)=='"'  || \
   (c)==EOF)


int read_form(void) {
  int c, c2;
  c = read_c_ci();

  while(1) {
    //remove leading whitespace
    while(c==' '||c=='\t'||c=='\n'||c=='\r') {
      if(Error_flag) return NIL;
      c = read_c_ci();
    }
    //insert code for reading things starting with #

    if(c!=';') break; //break if there is no trailing comment

    //remove everything after comment from stream until newline or EOF
    while(c!='\n' && c!=EOF)
      c = read_c_ci();
  }

  if(c==EOF) return ENDOFFILE;

  if(c=='(') {
    return read_list();
  }
}

int xread(void) {
  Level=0;
  return read_form();
}

void print(int n) {

}

int find_symbol(char *s) {
  int y;
  
  y = Symbols;
  while(y!=NIL) {
    if(!strcmp(string(Car[y]), s)) {
      return Car[y];
    } else {
      y = Cdr[y];
    }
  }
  return NIL;
}

int make_symbol(char *s, int k) {
  int n;
  
  n = allocv(S_symbol, k+1);
  strcpy(string(n), s); //WHAT
  return n;
}

int add_symbol(char *s) {
  int y;

  y=find_symbol(s);
  if(y!=NIL) return y;
  Symbols = alloc(NIL, Symbols);
  Car[Symbols] = make_symbol(s, strlen(s));
  return Car[Symbols];
}

void init(void) {
  new_segment();
  gc();

  S_symbol = add_symbol("#<symbol>");
  S_integer = add_symbol("#<integer>");

  Environment = make_initial_env();
  Program = TRUE;
  rehash(Car[Environment]);
}

int main(void) {
  init();
  //load_library(); //load scm library

  repl();
  return 0;
}
