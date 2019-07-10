%{
#include "parser.tab.h"
%}

TK_DECLARATION_IMPORT         "import"
TK_DECLARATION_FUNCTION       "func"
TK_DECLARATION_VARIABLE       "let"
TK_DECLARATION_INT            "int"
TK_DECLARATION_FLOAT          "float"
TK_DECLARATION_STRING         "string"
TK_DECLARATION_BOOL           "bool"
TK_INT                        [0-9]+
TK_FLOAT                      [0-9]+\.[0-9]+
TK_STRING                     \'(.*)\'
TK_COMMENT                    \/\/.*
TK_TEMPLATE_STRING            (\').*\$\{[a-zA-Z]+(\+|\-|\=|\*|\/)*[0-9]*\}.*(\')
TK_BOOL                       "true"|"false"
TK_NULL                       "null"
TK_COMMA                      ","
TK_SEMICOLON                  ";"
TK_COLON                      ":"
TK_OPEN_PARENTHESIS           "("
TK_CLOSE_PARENTHESIS          ")"
TK_OPEN_CURLYBRACKETS         "{"
TK_CLOSE_CURLYBRACKETS        "}"
TK_OPEN_BRACKETS              "["
TK_CLOSE_BRACKETS             "]"
TK_LESS_THAN                  "<"
TK_LESS_EQUAL_THAN            "<="
TK_GREATER_THAN               ">"
TK_GREATER_EQUAL_THAN         ">="
TK_NOT_EQUAL                  "!="
TK_EQUAL                      "=="
TK_INCREMENT                  "++"
TK_DECREMENT                  "--"
TK_ATRIBUTION                 "="
TK_PLUS                       "+"
TK_MINUS                      "-"
TK_TIMES                      "*"
TK_POW                        "**"
TK_DIVIDED                    "/"
TK_MOD                        "%"
TK_NOT                        "!"
TK_AND                        "&&"
TK_OR                         "||"
TK_IF                         "if"
TK_ELSE                       "else"
TK_WHILE                      "while"
TK_FOR                        "for"
TK_RETURN                     "ret"
TK_PRINT                      "print"
TK_INPUT                      "input"
TK_IDENTIFIER                 [_a-zA-Z][_a-zA-Z0-9]*
TK_EOL                        [\r\n]
BLANK_SPACE                   [ \t]
INVALID_TOKEN                 .

%%

{TK_DECLARATION_IMPORT}       { return TK_DECLARATION_IMPORT; }
{TK_DECLARATION_FUNCTION}     { return TK_DECLARATION_FUNCTION; }
{TK_DECLARATION_VARIABLE}     { return TK_DECLARATION_VARIABLE; }
{TK_DECLARATION_INT}          { return TK_DECLARATION_INT; }
{TK_DECLARATION_FLOAT}        { return TK_DECLARATION_FLOAT; }
{TK_DECLARATION_STRING}       { return TK_DECLARATION_STRING; }
{TK_DECLARATION_BOOL}         { return TK_DECLARATION_BOOL; }
{TK_INT}                      { strncpy(yylval.simbolo, yytext, 50); return TK_INT; }
{TK_FLOAT}                    { strncpy(yylval.simbolo, yytext, 50); return TK_FLOAT; }
{TK_COMMENT}                  { strncpy(yylval.simbolo, yytext, 50); return TK_COMMENT; }
{TK_TEMPLATE_STRING}          { strncpy(yylval.simbolo, yytext, 50); return TK_TEMPLATE_STRING; }
{TK_STRING}                   { strncpy(yylval.simbolo, yytext, 50); return TK_STRING; }
{TK_BOOL}                     { strncpy(yylval.simbolo, yytext, 50); return TK_BOOL; }
{TK_NULL}                     { return TK_NULL; }
{TK_COMMA}                    { return TK_COMMA; }
{TK_SEMICOLON}                { return TK_SEMICOLON; }
{TK_COLON}                    { return TK_COLON; }
{TK_OPEN_PARENTHESIS}         { return TK_OPEN_PARENTHESIS; }
{TK_CLOSE_PARENTHESIS}        { return TK_CLOSE_PARENTHESIS; }
{TK_OPEN_CURLYBRACKETS}       { return TK_OPEN_CURLYBRACKETS; }
{TK_CLOSE_CURLYBRACKETS}      { return TK_CLOSE_CURLYBRACKETS; }
{TK_OPEN_BRACKETS}            { return TK_OPEN_BRACKETS; }
{TK_CLOSE_BRACKETS}           { return TK_CLOSE_BRACKETS; }
{TK_LESS_THAN}                { return TK_LESS_THAN; }
{TK_LESS_EQUAL_THAN}          { return TK_LESS_EQUAL_THAN; }
{TK_GREATER_THAN}             { return TK_GREATER_THAN; }
{TK_GREATER_EQUAL_THAN}       { return TK_GREATER_EQUAL_THAN; }
{TK_NOT_EQUAL}                { return TK_NOT_EQUAL; }
{TK_EQUAL}                    { return TK_EQUAL; }
{TK_INCREMENT}                { return TK_INCREMENT; }
{TK_DECREMENT}                { return TK_DECREMENT; }
{TK_ATRIBUTION}               { return TK_ATRIBUTION; }
{TK_PLUS}                     { return TK_PLUS; }
{TK_MINUS}                    { return TK_MINUS; }
{TK_TIMES}                    { return TK_TIMES; }
{TK_POW}                      { return TK_POW; }
{TK_DIVIDED}                  { return TK_DIVIDED; }
{TK_MOD}                      { return TK_MOD; }
{TK_NOT}                      { return TK_NOT; }
{TK_AND}                      { return TK_AND; }
{TK_OR}                       { return TK_OR; }
{TK_IF}                       { return TK_IF; }
{TK_ELSE}                     { return TK_ELSE; }
{TK_WHILE}                    { return TK_WHILE; }
{TK_FOR}                      { return TK_FOR; }
{TK_RETURN}                   { return TK_RETURN; }
{TK_PRINT}                    { return TK_PRINT; }
{TK_INPUT}                    { return TK_INPUT; }
{TK_IDENTIFIER}               { strncpy(yylval.simbolo, yytext, 50); return TK_IDENTIFIER; }
{TK_EOL}                      { return TK_EOL; }
{BLANK_SPACE}                 { return BLANK_SPACE; }
{INVALID_TOKEN}               { return INVALID_TOKEN; }

<<EOF>>                       printf("{\"type\": \"TK_EOF\"}\n"); return 0;

%%

int yywrap() {}
// int main() {
//   printf("[");
//   yylex();
//   printf("]\n");

//   return 0;
// }