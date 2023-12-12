%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct node {
    char id[10];
    int value;
    struct node *next;
} node_t;

node_t* head = NULL;

node_t* insert(node_t* l, char* lex, int value);
node_t* show(node_t* l);
node_t* get_node (node_t* l, char *lex);

int yylex(void);
void yyerror(char* s);
%}

%token NUMBER IDENT MAIS IGUAL TERM PRINT ABRE_PARENTESES FECHA_PARENTESES
%union
{
    int number;
    char *string;
    struct node_t *node;
}

%type <node> exp  // Declare the type of exp
%type <number> NUMBER
%type <node> TERM
%type <string> IDENT PRINT

%%
list: list statement
    |
    ;

statement: exp
    | PRINT ABRE_PARENTESES IDENT FECHA_PARENTESES TERM {
        printf("Printing variable '%s'\n", $3);
        node_t* p = get_node(head, $3);
        if (p != NULL) {
            printf("%s = %d\n", $3, p->value);
        } else {
            fprintf(stderr, "Variable not declared: %s\n", $3);
        }
    }
    ;

exp: IDENT IGUAL NUMBER TERM {
        head = insert(head, $1, $3);
        // show(head);
    }
    | IDENT IGUAL NUMBER MAIS NUMBER TERM {
        node_t *p = get_node(head, $1);
        if (p != NULL) {
            p->value = $3 + $5;
        } else {
            //SHOULD INSERT THE NEW VARIABLE WITH THE SUM
            head = insert(head, $1, $3 + $5);
        }
        show(head);
    }
    ;
%%

void yyerror(char *s) {
    fprintf(stderr, "erro: %s\n", s);
}

node_t* insert (node_t* l, char *lex, int value){
    node_t* novo = (node_t*) malloc(sizeof(node_t));
    strcpy(novo->id, lex);
    novo->value = value;
    novo->next=l;
    /* printf("%s %d \n", novo->id, novo->value); */
    return novo;
}

node_t* show (node_t* l){
    node_t* p;
    for (p = l; p != NULL; p = p->next)
    printf("%s %d \n", p->id, p->value);
};

node_t* get_node (node_t* l, char *lex) {
	node_t* p;
	for(p = l; p != NULL; p = p->next){
		if (strcmp(p->id,lex) == 0) { return p; }
	}
	return NULL;
}

int main(int argc, char** argv) {
    yyparse();
}