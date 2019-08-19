%{

/* Código C, use para #include, variáveis globais e constantes
 * este código ser adicionado no início do arquivo fonte em C
 * que será gerado.
 */

#include <stdio.h>
#include <stdlib.h>

typedef struct No {
    char type[50];
    char token[50];
    int siblings_num;
    struct No** siblings;
} No;


No* allocar_no();
void liberar_no(No* no);
void imprimir_arvore(No* raiz);
No* novo_no(char[50], No**, int);
No* cria_no_exp(char[50], char[50], No*, No*);

%}

/* Declaração de Tokens no formato %token NOME_DO_TOKEN */
%union 
{
    int number;
    int siblings_num;
    char simbolo[50];
    struct No* no;
}

%token  TK_DECLARATION_IMPORT
%token  TK_DECLARATION_FUNCTION
%token  TK_DECLARATION_VARIABLE
%token  TK_DECLARATION_INT
%token  TK_DECLARATION_FLOAT
%token  TK_DECLARATION_STRING
%token  TK_DECLARATION_BOOL
%token  TK_INT
%token  TK_FLOAT
%token  TK_STRING
%token  TK_COMMENT
%token  TK_TEMPLATE_STRING
%token  TK_BOOL
%token  TK_NULL
%token  TK_COMMA
%token  TK_SEMICOLON
%token  TK_COLON
%token  TK_OPEN_PARENTHESIS
%token  TK_CLOSE_PARENTHESIS
%token  TK_OPEN_CURLYBRACKETS
%token  TK_CLOSE_CURLYBRACKETS
%token  TK_OPEN_BRACKETS
%token  TK_CLOSE_BRACKETS
%token  TK_LESS_THAN
%token  TK_LESS_EQUAL_THAN
%token  TK_GREATER_THAN
%token  TK_GREATER_EQUAL_THAN
%token  TK_NOT_EQUAL
%token  TK_EQUAL
%token  TK_INCREMENT
%token  TK_DECREMENT
%token  TK_ATRIBUTION
%token  TK_PLUS
%token  TK_MINUS
%token  TK_TIMES
%token  TK_POW
%token  TK_DIVIDED
%token  TK_MOD
%token  TK_NOT
%token  TK_AND
%token  TK_OR
%token  TK_IF
%token  TK_ELSE
%token  TK_WHILE
%token  TK_FOR
%token  TK_RETURN
%token  TK_PRINT
%token  TK_INPUT
%token  TK_IDENTIFIER
%token  TK_EOL
%token  BLANK_SPACE
%token  INVALID_TOKEN


%type <simbolo> TK_INT
%type <simbolo> TK_FLOAT

%type <simbolo> TK_PLUS
%type <simbolo> TK_MINUS
%type <simbolo> TK_TIMES
%type <simbolo> TK_DIVIDED

%type <no> calc
%type <no> expr
%type <no> factor
%type <no> term

%%

calc:
| calc expr TK_EOL { imprimir_arvore($2); printf("\n"); }
;

expr:
| factor
| expr TK_PLUS factor { $$ = cria_no_exp("TK-PLUS", "EXP", $1, $3); }
| expr TK_MINUS factor { $$ = cria_no_exp("TK-MINUS", "EXP", $1, $3); }
| expr TK_LESS_THAN factor { $$ = cria_no_exp("TK-LESS_THAN", "EXP", $1, $3); }
| expr TK_LESS_EQUAL_THAN factor { $$ = cria_no_exp("TK-LESS_EQUAL_THAN", "EXP", $1, $3); }
| expr TK_GREATER_THAN factor { $$ = cria_no_exp("TK-GREATER_THAN", "EXP", $1, $3); }
| expr TK_GREATER_EQUAL_THAN factor { $$ = cria_no_exp("TK-GREATER_EQUAL_THAN", "EXP", $1, $3); }
| expr TK_EQUAL factor { $$ = cria_no_exp("TK-EQUAL", "EXP", $1, $3); }
| expr TK_NOT_EQUAL factor { $$ = cria_no_exp("TK-NOT_EQUAL", "EXP", $1, $3); }
| expr TK_AND factor { $$ = cria_no_exp("TK-AND", "EXP", $1, $3); }
| expr TK_OR factor { $$ = cria_no_exp("TK-OR", "EXP", $1, $3); }
;

factor:
| term
| factor TK_TIMES term { $$ = cria_no_exp("TK-TIMES", "FACTOR", $1, $3); }
| factor TK_DIVIDED term { $$ = cria_no_exp("TK-DIVIDED", "FACTOR", $1, $3); }
| factor TK_MOD term { $$ = cria_no_exp("TK-MOD", "FACTOR", $1, $3); }
| factor TK_POW term { $$ = cria_no_exp("TK-POW", "FACTOR", $1, $3); }
;

term: 
|    TK_INT {
            No** siblings = (No**) malloc(sizeof(No*));
            siblings[0] = novo_no($1,siblings,0);
            $$ = novo_no("TK-INT", siblings, 1);
        }
|    TK_FLOAT {
            No** siblings = (No**) malloc(sizeof(No*));
            siblings[0] = novo_no($1,siblings,0);
            $$ = novo_no("TK-FLOAT", siblings, 1);
        }
;
%%

No* allocar_no(int siblings_num) {
    return (No*) malloc(sizeof(No)* siblings_num);
}

void liberar_no(No* no) {
    free(no);
}

No* novo_no(char token[50], No** siblings, int siblings_num) {
    No* no = allocar_no(siblings_num);
    snprintf(no->token, 50, "%s", token);
    no->siblings_num= siblings_num;
    no->siblings = siblings;
    return no;
}

void imprimir_arvore(No* raiz) {
    int i = 0;
    printf("[%s ", raiz->token);
    while (i < raiz->siblings_num)
    {  
        imprimir_arvore(raiz->siblings[i]);
        i++;
    }
    printf("]");
}

No* cria_no_exp(char token[50], char type[50], No* sibling_1, No* sibling_2) {
    No** siblings = (No**) malloc(sizeof(No*)*3);
    siblings[0] = sibling_1;
    siblings[1] = novo_no(token, NULL, 0);
    siblings[2] = sibling_2;
    return novo_no(type, siblings, 3);
}

int main(int argc, char** argv) {
    yyparse();
}

yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}

