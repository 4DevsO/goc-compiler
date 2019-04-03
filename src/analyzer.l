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

%%

{TK_DECLARATION_IMPORT} ret formatToken("TK_DECLARATION_IMPORT");
{TK_DECLARATION_FUNCTION} ret formatToken("TK_DECLARATION_FUNCTION");
{TK_DECLARATION_VARIABLE} ret formatToken("TK_DECLARATION_VARIABLE");
{TK_DECLARATION_INT} ret formatToken("TK_DECLARATION_INT");
{TK_DECLARATION_FLOAT} ret formatToken("TK_DECLARATION_FLOAT");
{TK_DECLARATION_STRING} ret formatToken("TK_DECLARATION_STRING");
{TK_DECLARATION_BOOL} ret formatToken("TK_DECLARATION_BOOL");
{TK_INT} ret formatToken("TK_INT");
{TK_FLOAT} ret formatToken("TK_FLOAT");
{TK_COMMENT} ret formatToken("TK_COMMENT");
{TK_TEMPLATE_STRING} ret formatToken("TK_TEMPLATE_STRING");
{TK_STRING} ret formatToken("TK_STRING");
{TK_BOOL} ret formatToken("TK_BOOL");
{TK_NULL} ret formatToken("TK_NULL");
{TK_COMMA} ret formatToken("TK_COMMA");
{TK_SEMICOLON} ret formatToken("TK_SEMICOLON");
{TK_COLON} ret formatToken("TK_COLON");
{TK_OPEN_PARENTHESIS} ret formatToken("TK_OPEN_PARENTHESIS");
{TK_CLOSE_PARENTHESIS} ret formatToken("TK_CLOSE_PARENTHESIS");
{TK_OPEN_CURLYBRACKETS} ret formatToken("TK_OPEN_CURLYBRACKETS");
{TK_CLOSE_CURLYBRACKETS} ret formatToken("TK_CLOSE_CURLYBRACKETS");
{TK_OPEN_BRACKETS} ret formatToken("TK_OPEN_BRACKETS");
{TK_CLOSE_BRACKETS} ret formatToken("TK_CLOSE_BRACKETS");
{TK_LESS_THAN} ret formatToken("TK_LESS_THAN");
{TK_LESS_EQUAL_THAN} ret formatToken("TK_LESS_EQUAL_THAN");
{TK_GREATER_THAN} ret formatToken("TK_GREATER_THAN");
{TK_GREATER_EQUAL_THAN} ret formatToken("TK_GREATER_EQUAL_THAN");
{TK_NOT_EQUAL} ret formatToken("TK_NOT_EQUAL");
{TK_EQUAL} ret formatToken("TK_EQUAL");
{TK_INCREMENT} formatToken("TK_INCREMENT");
{TK_DECREMENT} formatToken("TK_DECREMENT");
{TK_ATRIBUTION} formatToken("TK_ATRIBUTION");
{TK_PLUS} formatToken("TK_PLUS");
{TK_MINUS} formatToken("TK_MINUS");
{TK_TIMES} formatToken("TK_TIMES");
{TK_POW} formatToken("TK_POW");
{TK_DIVIDED} formatToken("TK_DIVIDED");
{TK_MOD} formatToken("TK_MOD");
{TK_NOT} formatToken("TK_NOT");
{TK_AND} formatToken("TK_AND");
{TK_OR} formatToken("TK_OR");
{TK_IF} formatToken("TK_IF");
{TK_ELSE} formatToken("TK_ELSE");
{TK_WHILE} formatToken("TK_WHILE");
{TK_FOR} formatToken("TK_FOR");
{TK_RETURN} formatToken("TK_RETURN");
{TK_PRINT} formatToken("TK_PRINT");
{TK_INPUT} formatToken("TK_INPUT");
{TK_IDENTIFIER} formatToken("TK_IDENTIFIER");
{BLANK_SPACE} formatToken("BLANK_SPACE");

<<EOF>> printf("{\"type\": \"TK_EOF\"}\n"); return 0;

%%

int yywrap() {}
int main() {
    printf("[");
    yylex();
    printf("]\n");

    return 0;
}