%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct node {
    char id[10];
    int value;
    struct node *next;
} node_t;

node_t *head = NULL;

node_t* insert(node_t* l, char* lex, int value);
node_t* show(node_t* l);

int yylex(void);
void yyerror(char* s);
%}

%token NUMBER IDENT MAIS MENOS IGUAL TERM
%left MENOS
%union
{
    int number;
    char *string;
    struct node_t *node;
}

%type <node> exp  // Declare the type of exp
%type <number> NUMBER
%type <node> TERM
%type <string> IDENT

%%

list: list exp
    |
    ;

exp: IDENT IGUAL NUMBER TERM {
        head = insert(head, $1, $3);
        show(head);
    }
    ;
%%

void yyerror(char *s) {
    fprintf(stderr, "erro: %s\n", s);
}

node_t* insert (node_t* l, char *lex, int value){
    node_t* novo = (node_t*) malloc(sizeof(l));
    strcpy(novo->id, lex);
    novo->value = value;
    novo->next=l;
    return novo;
}

node_t* show (node_t* l){
    node_t* p;
    for (p = l; p != NULL; p = p->next)
    printf("%s %d \n", p->id, p->value);
};

int main(int argc, char** argv) {
    yyparse();
}