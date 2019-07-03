%{
  // Format tokens to a JSON list
  void formatToken(char* tokenName) {
    if(strcmp(tokenName, "BLANK_SPACE") == 0){
      return;
    }
    printf("{\"type\": \"%s\", \"value\": \"%s\"},\n", tokenName, yytext);
  }
%}

TK_DECLARATION_IMPORT         "import"
TK_DECLARATION_FUNCTION       "func"
TK_DECLARATION_VARIABLE       "let"
TK_DECLARATION_INT            "int"
TK_DECLARATION_FLOAT          "float"
TK_DECLARATION_STRING         "string"
TK_DECLARATION_BOOL           "bool"
TK_INT                        [0-9]+
TK_FLOAT                      [0-9]+.[0-9]+
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
BLANK_SPACE                   [ \r\n\t]
INVALID_TOKEN                 .

%%

{TK_DECLARATION_IMPORT}       formatToken("TK_DECLARATION_IMPORT");
{TK_DECLARATION_FUNCTION}     formatToken("TK_DECLARATION_FUNCTION");
{TK_DECLARATION_VARIABLE}     formatToken("TK_DECLARATION_VARIABLE");
{TK_DECLARATION_INT}          formatToken("TK_DECLARATION_INT");
{TK_DECLARATION_FLOAT}        formatToken("TK_DECLARATION_FLOAT");
{TK_DECLARATION_STRING}       formatToken("TK_DECLARATION_STRING");
{TK_DECLARATION_BOOL}         formatToken("TK_DECLARATION_BOOL");
{TK_INT}                      formatToken("TK_INT");
{TK_FLOAT}                    formatToken("TK_FLOAT");
{TK_COMMENT}                  formatToken("TK_COMMENT");
{TK_TEMPLATE_STRING}          formatToken("TK_TEMPLATE_STRING");
{TK_STRING}                   formatToken("TK_STRING");
{TK_BOOL}                     formatToken("TK_BOOL");
{TK_NULL}                     formatToken("TK_NULL");
{TK_COMMA}                    formatToken("TK_COMMA");
{TK_SEMICOLON}                formatToken("TK_SEMICOLON");
{TK_COLON}                    formatToken("TK_COLON");
{TK_OPEN_PARENTHESIS}         formatToken("TK_OPEN_PARENTHESIS");
{TK_CLOSE_PARENTHESIS}        formatToken("TK_CLOSE_PARENTHESIS");
{TK_OPEN_CURLYBRACKETS}       formatToken("TK_OPEN_CURLYBRACKETS");
{TK_CLOSE_CURLYBRACKETS}      formatToken("TK_CLOSE_CURLYBRACKETS");
{TK_OPEN_BRACKETS}            formatToken("TK_OPEN_BRACKETS");
{TK_CLOSE_BRACKETS}           formatToken("TK_CLOSE_BRACKETS");
{TK_LESS_THAN}                formatToken("TK_LESS_THAN");
{TK_LESS_EQUAL_THAN}          formatToken("TK_LESS_EQUAL_THAN");
{TK_GREATER_THAN}             formatToken("TK_GREATER_THAN");
{TK_GREATER_EQUAL_THAN}       formatToken("TK_GREATER_EQUAL_THAN");
{TK_NOT_EQUAL}                formatToken("TK_NOT_EQUAL");
{TK_EQUAL}                    formatToken("TK_EQUAL");
{TK_INCREMENT}                formatToken("TK_INCREMENT");
{TK_DECREMENT}                formatToken("TK_DECREMENT");
{TK_ATRIBUTION}               formatToken("TK_ATRIBUTION");
{TK_PLUS}                     formatToken("TK_PLUS");
{TK_MINUS}                    formatToken("TK_MINUS");
{TK_TIMES}                    formatToken("TK_TIMES");
{TK_POW}                      formatToken("TK_POW");
{TK_DIVIDED}                  formatToken("TK_DIVIDED");
{TK_MOD}                      formatToken("TK_MOD");
{TK_NOT}                      formatToken("TK_NOT");
{TK_AND}                      formatToken("TK_AND");
{TK_OR}                       formatToken("TK_OR");
{TK_IF}                       formatToken("TK_IF");
{TK_ELSE}                     formatToken("TK_ELSE");
{TK_WHILE}                    formatToken("TK_WHILE");
{TK_FOR}                      formatToken("TK_FOR");
{TK_RETURN}                   formatToken("TK_RETURN");
{TK_PRINT}                    formatToken("TK_PRINT");
{TK_INPUT}                    formatToken("TK_INPUT");
{TK_IDENTIFIER}               formatToken("TK_IDENTIFIER");
{BLANK_SPACE}                 formatToken("BLANK_SPACE");
{INVALID_TOKEN}               formatToken("INVALID_TOKEN");

<<EOF>>                       printf("{\"type\": \"TK_EOF\"}\n"); return 0;

%%

int yywrap() {}
int main() {
    printf("[");
    yylex();
    printf("]\n");

    return 0;
}