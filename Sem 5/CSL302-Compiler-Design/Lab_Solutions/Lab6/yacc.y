%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;

int yylex(void);
void yyerror(const char *s);

int error_flag = 0;

typedef struct Symbol {
    char *name;
    int value;
    struct Symbol *next;
} Symbol;

Symbol *symtab = NULL;

Symbol* lookup(char *name) {
    Symbol *s = symtab;
    while (s) {
        if (strcmp(s->name, name) == 0) return s;
        s = s->next;
    }
    return NULL;
}

void assign(char *name, int val) {
    Symbol *s = lookup(name);
    if (s) {
        s->value = val;
    } else {
        s = (Symbol *)malloc(sizeof(Symbol));
        s->name = strdup(name);
        s->value = val;
        s->next = symtab;
        symtab = s;
    }
}

int getval(char *name) {
    Symbol *s = lookup(name);
    if (s) return s->value;
    return 0;
}

%}

%union {
    int num;
    char* id;
}

%token <id> ID
%token <num> NUMBER
%token INT FLOAT FOR IF THEN ELSE ELIF SWITCH CASE WHILE DO
%token EQ NE LE GE

%type <num> STMTS STMT BLOCK EXP BOOL EXP_LIST STMT_LIST CASE_LIST CASE_STMT

%start STMTS

%left '+' '-'
%left '*' '/' '%'
%left EQ NE '<' '>' LE GE
%right '='

%%

STMTS : STMTS STMT
      | STMT
      ;

STMT  : decl_stmt ';'
      | assign_stmt ';'
      | if_stmt
      | switch_stmt
      | while_stmt
      | do_while_stmt
      | for_stmt
      ;

decl_stmt
    : type ID_LIST
        { printf("Declaration\n"); }
    ;

type
    : INT
    | FLOAT
    ;

ID_LIST
    : ID
    | ID_LIST ',' ID
    ;

assign_stmt
    : ID '=' EXP
        { assign($1, $3); printf("Assignment: %s = %d\n", $1, $3); free($1); }
    ;

EXP
    : EXP '+' EXP    { $$ = $1 + $3; }
    | EXP '-' EXP    { $$ = $1 - $3; }
    | EXP '*' EXP    { $$ = $1 * $3; }
    | EXP '/' EXP    { $$ = $1 / $3; }
    | EXP '%' EXP    { $$ = $1 % $3; }
    | '(' EXP ')'    { $$ = $2; }
    | NUMBER         { $$ = $1; }
    | ID             { $$ = getval($1); free($1); }
    ;

BOOL
    : EXP '<' EXP   { $$ = $1 < $3; }
    | EXP '>' EXP   { $$ = $1 > $3; }
    | EXP LE EXP    { $$ = $1 <= $3; }
    | EXP GE EXP    { $$ = $1 >= $3; }
    | EXP EQ EXP    { $$ = $1 == $3; }
    | EXP NE EXP    { $$ = $1 != $3; }
    | EXP          { $$ = $1 != 0; }
    ;

BLOCK
    : '{' STMTS '}'
    ;

if_stmt
    : IF '(' BOOL ')' THEN BLOCK
        { printf("if-then executed\n"); }
    | IF '(' BOOL ')' THEN BLOCK ELSE BLOCK
        { printf("if-then-else executed\n"); }
    | IF '(' BOOL ')' THEN BLOCK ELIF '(' BOOL ')' BLOCK ELSE BLOCK
        { printf("if-then-elif-else executed\n"); }
    ;

switch_stmt
    : SWITCH '(' EXP ')' '{' CASE_LIST '}'
        { printf("switch-case executed\n"); }
    ;

CASE_LIST
    : CASE_LIST CASE_STMT
    | CASE_STMT
    ;

CASE_STMT
    : CASE NUMBER ':' STMT_LIST
    ;

STMT_LIST
    : STMT_LIST STMT
    | STMT
    ;

while_stmt
    : WHILE '(' BOOL ')' BLOCK
        { printf("while loop executed\n"); }
    ;

do_while_stmt
    : DO BLOCK WHILE '(' BOOL ')' ';'
        { printf("do-while loop executed\n"); }
    ;

for_stmt
    : FOR '(' assign_stmt ';' BOOL ';' assign_stmt ')' STMT
        { printf("for loop executed\n"); }
    ;

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Could not open file");
            return 1;
        }
        yyin = file;  // yyin is the lex input file pointer
    } else {
        printf("\nEnter your code (end with Ctrl+D):\n");
    }

    yyparse();

    if (!error_flag)
        printf("\nParsing completed successfully.\n");
    else
        printf("\nParsing finished with errors.\n");

    if (argc > 1)
        fclose(yyin);

    return 0;
}


void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
    error_flag = 1;
}

