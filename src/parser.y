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
    struct No* direita;
    struct No* esquerda;
} No;


No* allocar_no();
void liberar_no(void* no);
void imprimir_arvore(No* raiz);
No* novo_no(char[50], char[50], No*, No*);

%}

/* Declaração de Tokens no formato %token NOME_DO_TOKEN */
%union 
{
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
| expr TK_PLUS factor { $$ = novo_no("TK_PLUS", NULL, $1, $3); }
| expr TK_MINUS factor { $$ = novo_no("TK_MINUS", NULL, $1, $3); }
| expr TK_POW factor { $$ = novo_no("TK_POW", NULL, $1, $3); }
| expr TK_MOD factor { $$ = novo_no("TK_MOD", NULL, $1, $3); }
| expr TK_AND factor { $$ = novo_no("TK_AND", NULL, $1, $3); }
| expr TK_OR factor { $$ = novo_no("TK_OR", NULL, $1, $3); }
| expr TK_LESS_THAN factor { $$ = novo_no("TK_LESS_THAN", NULL, $1, $3); }
| expr TK_LESS_EQUAL_THAN factor { $$ = novo_no("TK_LESS_EQUAL_THAN", NULL, $1, $3); }
| expr TK_GREATER_THAN factor { $$ = novo_no("TK_GREATER_THAN", NULL, $1, $3); }
| expr TK_GREATER_EQUAL_THAN factor { $$ = novo_no("TK_GREATER_EQUAL_THAN", NULL, $1, $3); }
| expr TK_NOT_EQUAL factor { $$ = novo_no("TK_NOT_EQUAL", NULL, $1, $3); }
| expr TK_EQUAL factor { $$ = novo_no("TK_EQUAL", NULL, $1, $3); }
;

factor:
| term
| factor TK_TIMES term { $$ = novo_no("TK_TIMES", NULL, $1, $3); }
| factor TK_DIVIDED term { $$ = novo_no("TK_DIVIDED", NULL, $1, $3); }
;

term:
| TK_INT { $$ = novo_no("TK_INT", $1, NULL, NULL); }
| TK_FLOAT { $$ = novo_no("TK_FLOAT", $1, NULL, NULL); }
;

%%

No* allocar_no() {
    return (No*) malloc(sizeof(No));
}

void liberar_no(void* no) {
    free(no);
}

No* novo_no(char type[50], char token[50], No* direita, No* esquerda) {
   No* no = allocar_no();
   snprintf(no->type, 50, "%s", type);
   snprintf(no->token, 50, "%s", token);
   no->direita = direita;
   no->esquerda = esquerda;

   return no;
}

void imprimir_arvore(No* raiz) {
    
    if(raiz == NULL) {
        return;
    }
    printf("(");
    imprimir_arvore(raiz->direita);
    if(strcmp(raiz->token, "(null)") != 0) {
        printf("%s, %s", raiz->type, raiz->token);
    } else {
        printf("%s", raiz->type);
    }
    imprimir_arvore(raiz->esquerda);
    printf(")");
    
    free(raiz);

}


int main(int argc, char** argv) {
    yyparse();
}

yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}

