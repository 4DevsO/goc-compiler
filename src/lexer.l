%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"
%}

%%

"print"       { return PRINT; }
[ \t]         ;  // Ignore whitespace
[0-9]+        { yylval.number = atoi(yytext); return NUMBER; }
[a-zA-Z]+     { yylval.string = strdup(yytext); return IDENT; }
"="           { return IGUAL; }
"+"           { return MAIS; }
";"           { return TERM; }
"("           { return ABRE_PARENTESES; }
")"           { return FECHA_PARENTESES; }


%%

int yywrap() {}
