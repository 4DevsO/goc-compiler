%{
#include "simbolo.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define T_INTEIRO 0
#define T_FLOAT 1

Simbolo_t* head = NULL;

Simbolo_t* adicionarSimbolo (Simbolo_t* node, Simbolo_t simbolo);
Simbolo_t* atualizarSimbolo (Simbolo_t* node, Simbolo_t simbolo);
Simbolo_t* buscarSimbolo (Simbolo_t* node, char id);
void imprimirSimbolo (Simbolo_t* node);

%}

%token <id> ID
%token <intValue> INTEIRO
%token <floatValue> FLOAT
%token MAIS IGUAL PRINT PONTO_VIRGULA ABRE_PARENTESES FECHA_PARENTESES

 %union {
    int intValue;
    float floatValue;
    char id;
    int tipo;
    Simbolo_t symbol;
 } 

 %type <symbol> expressao termo
%%

programa: listaComandos
    ;

listaComandos: listaComandos comando 
    | comando
    ;

comando: atribuicao 
    | PRINT ABRE_PARENTESES ID FECHA_PARENTESES PONTO_VIRGULA{
        Simbolo_t* simbolo = buscarSimbolo(head, $3);
        if (simbolo != NULL) {
            imprimirSimbolo(simbolo);
        } else {
            fprintf(stderr, "Variavel nao declarada");
        }
    }
    ;

atribuicao: ID IGUAL expressao PONTO_VIRGULA{ 
        Simbolo_t* simbolo = buscarSimbolo(head, $1);
        if (simbolo == NULL) {
            Simbolo_t novoSimbolo;
            novoSimbolo.id = $1;
            novoSimbolo.tipo = $3.tipo;
            novoSimbolo.valor = $3.valor;
            head = adicionarSimbolo(head, novoSimbolo);
        } else {
            if (simbolo->tipo == $3.tipo) {
                atualizarSimbolo(simbolo, $3);
            } else {
                fprintf(stderr,"Warning: Atribuição com tipos diferentes\n");
            }
        }
    }
    ;

expressao: termo MAIS termo { 
        if ($1.tipo == T_INTEIRO && $3.tipo == T_INTEIRO) {
            $$.tipo = T_INTEIRO;
            $$.valor.intValue  = $1.valor.intValue + $3.valor.intValue;
        } else if ($1.tipo == T_FLOAT && $3.tipo == T_INTEIRO) {
            $$.tipo = T_FLOAT;
            $$.valor.floatValue = (float) ($1.valor.floatValue + $3.valor.intValue);
            fprintf(stderr, "Warning: Soma com tipos diferentes\n");
        } else if ($1.tipo == T_INTEIRO && $3.tipo == T_FLOAT) {
            $$.tipo = T_FLOAT;
            $$.valor.floatValue = (float) ($1.valor.intValue + $3.valor.floatValue);
            fprintf(stderr, "Warning: Soma com tipos diferentes\n");
        } else if ($1.tipo == T_FLOAT && $3.tipo == T_FLOAT) {
            $$.tipo = T_FLOAT;
            $$.valor.floatValue = (float) ($1.valor.floatValue + $3.valor.floatValue);
        } 
    }
    | termo { 
        $$ = $1;
    }
    ;

termo: ID {
        Simbolo_t* simbolo = buscarSimbolo(head, $1);
        if (simbolo != NULL) {
            $$ = *simbolo;
        } else {
            fprintf(stderr, "Variavel nao declarada");
        }
    }
    | INTEIRO {
        $$.id = '\0'; // '\0' representa uma constante
        $$.tipo = T_INTEIRO;
        $$.valor.intValue = $1;
    }
    | FLOAT { 
        $$.id = '\0';  // '\0' representa uma constante
        $$.tipo = T_FLOAT;
        $$.valor.floatValue = $1;
    }
    ;



%%

/**
 * Função responsável por adicionar um símbolo à lista de símbolos.
 * 
 * @param node O nó atual da lista de símbolos.
 * @param simbolo O símbolo a ser adicionado.
 * @return O novo nó da lista de símbolos.
 */
Simbolo_t* adicionarSimbolo(Simbolo_t* node, Simbolo_t simbolo) {
    if (node == NULL) {
        node = (Simbolo_t*)malloc(sizeof(Simbolo_t));
        node->id = simbolo.id;
        node->tipo = simbolo.tipo;

        if (simbolo.tipo == T_INTEIRO) {
            node->valor.intValue = simbolo.valor.intValue;
        } else if (simbolo.tipo == T_FLOAT) {
            node->valor.floatValue = simbolo.valor.floatValue;
        }

        node->prox = NULL;
    } else {
        node->prox = adicionarSimbolo(node->prox, simbolo);
    }

    return node;
}


/**
 * Função responsável por atualizar um símbolo.
 * 
 * @param node O nó do símbolo a ser atualizado.
 * @param simbolo O novo valor do símbolo.
 * @return O nó do símbolo atualizado.
 */
Simbolo_t* atualizarSimbolo (Simbolo_t* node, Simbolo_t simbolo) {
    if (simbolo.id == '\0') {
        //printf("Atualizando simbolo com constante\n");
        if (node->tipo == T_INTEIRO) {
            node->valor.intValue = simbolo.valor.intValue;
        } else if (node->tipo == T_FLOAT) {
            node->valor.floatValue = simbolo.valor.floatValue;
        }
    } else {
        //printf("Atualizando simbolo com outro simbolo\n");
        if (node->tipo == T_INTEIRO) {
            node->valor.intValue = simbolo.valor.intValue;
        } else if (node->tipo == T_FLOAT) {
            node->valor.floatValue = simbolo.valor.floatValue;
        }
    }
    return node;
}

/**
 * Função responsável por buscar um símbolo na árvore de símbolos.
 *
 * @param node O nó raiz da árvore de símbolos.
 * @param id O identificador do símbolo a ser buscado.
 * @return Um ponteiro para o símbolo encontrado ou NULL caso não seja encontrado.
 */
Simbolo_t* buscarSimbolo (Simbolo_t* node, char id) {
    for (Simbolo_t* aux = node; aux != NULL; aux = aux->prox) {
        if (aux->id == id) {
            return aux;
        }
    }
    return NULL;
}

/**
 * Função responsável por imprimir um símbolo.
 * 
 * @param node O ponteiro para o símbolo a ser impresso.
 */
void imprimirSimbolo (Simbolo_t* node) {
    for (Simbolo_t* aux = node; aux != NULL; aux = aux->prox) {
        if (aux->id == node->id) {
            if (aux->tipo == T_INTEIRO) {
                printf("%d\n", aux->valor.intValue);
            } else if (aux->tipo == T_FLOAT) {
                printf("%f\n", aux->valor.floatValue);
            }
        }
    }
}

void yyerror(char* s) {
    extern int yylineno;   
    extern char *yytext;   
    fprintf(stderr, "Erro de sintaxe: %s. Na linha %d, próximo a '%s'\n", s, yylineno, yytext);
}

extern FILE *yyin;
int main() {
    do {
        yyparse();
    } while (!feof(yyin));
    return 0;
}
