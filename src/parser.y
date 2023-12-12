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

%token  TK_INT
%token  TK_FLOAT
%token  TK_SEMICOLON
%token  TK_OPEN_PARENTHESIS
%token  TK_CLOSE_PARENTHESIS
%token  TK_ATRIBUTION
%token  TK_PLUS
%token  TK_PRINT
%token  TK_IDENTIFIER
%token  TK_EOL
%token  BLANK_SPACE
%token  INVALID_TOKEN


%type <simbolo> TK_INT
%type <simbolo> TK_FLOAT
%type <simbolo> TK_PLUS
%type <simbolo> TK_IDENTIFIER


%type <no> calc
%type <no> expr
%type <no> term

%%

calc:
{printf("Iniciando calc...\n");}
| calc expr TK_EOL { imprimir_arvore($2); printf("\n"); }
// {printf("Finalizando calc.\n");}
;

expr:
{printf("Iniciando expr...\n");}
| term
| expr TK_ATRIBUTION term { $$ = novo_no("TK_ATRIBUTION", NULL, $1, $3); imprimir_arvore($1); }
| expr TK_PLUS term { $$ = novo_no("TK_PLUS", NULL, $1, $3); }
| expr TK_IDENTIFIER { $$ = novo_no("TK_IDENTIFIER", NULL, $1, $3); }
// {printf("Finalizando expr.\n");}
;

term:
{printf("Iniciando term...\n");}
| TK_INT { $$ = novo_no("TK_INT", $1, NULL, NULL); }
| TK_FLOAT { $$ = novo_no("TK_FLOAT", $1, NULL, NULL); }
// {printf("Finalizando term.\n");}
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

