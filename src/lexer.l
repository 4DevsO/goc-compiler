%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"
%}

%%

[0-9]+? {yylval.number=atoi(yytext); return NUMBER;}
[a-zA-Z]+ {yylval.string=strdup(yytext); return IDENT;}
= return IGUAL;
"+" return MAIS;
";" return TERM;

%%

int yywrap() {}
