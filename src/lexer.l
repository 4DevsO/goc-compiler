%{
#include "parser.tab.h"
%}

TK_INT                        [0-9]+
TK_FLOAT                      [0-9]+\.[0-9]+
TK_SEMICOLON                  ";"
TK_OPEN_PARENTHESIS           "("
TK_CLOSE_PARENTHESIS          ")"
TK_ATRIBUTION                 "="
TK_PLUS                       "+"
TK_PRINT                      "print"
TK_IDENTIFIER                 [a-zA-Z]
TK_EOL                        [\r\n]
BLANK_SPACE                   [ \t]
INVALID_TOKEN                 .

%%

{TK_INT}                      { strncpy(yylval.simbolo, yytext, 50); return TK_INT; }
{TK_FLOAT}                    { strncpy(yylval.simbolo, yytext, 50); return TK_FLOAT; }
{TK_SEMICOLON}                { return TK_SEMICOLON; }
{TK_OPEN_PARENTHESIS}         { return TK_OPEN_PARENTHESIS; }
{TK_CLOSE_PARENTHESIS}        { return TK_CLOSE_PARENTHESIS; }
{TK_ATRIBUTION}               { return TK_ATRIBUTION; }
{TK_PLUS}                     { return TK_PLUS; }
{TK_PRINT}                    { return TK_PRINT; }
{TK_IDENTIFIER}               { return TK_IDENTIFIER; }
{TK_EOL}                      { return TK_EOL; }
{BLANK_SPACE}                 { return BLANK_SPACE; }
{INVALID_TOKEN}               { return INVALID_TOKEN; }

<<EOF>>                       printf("{\"type\": \"TK_EOF\"}\n"); return 0;

%%

int yywrap() {}