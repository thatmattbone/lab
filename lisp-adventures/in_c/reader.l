%{
#include <stdio.h>
#include "reader.tab.h"
%}

%%
\(                      return LPAREN;
\)                      return RPAREN;
\+                      return PLUS;
\-                      return MINUS;
\*                      return MULT;
\/                      return DIV;
[0-9]+                  yylval=atoi(yytext); return INTEGER;
[0-9.-]+                return DOUBLE;
lambda                  return LAMBDA;
cond                    return COND;
[a-zA-Z][a-zA-Z0-9]*    return SYMBOL;
\n                      /* return NEWLINE */;
[ \t]+                  /* ignore whitespace */;
%%
