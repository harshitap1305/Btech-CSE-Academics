%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ---------- Symbol Table ---------- */

typedef struct symtab_entry {
    char *name;
    char *type;
    struct symtab_entry *next;
} symtab_entry;

symtab_entry *symbol_table = NULL;

symtab_entry* lookup(char *name) {
    symtab_entry *current = symbol_table;
    while(current) {
        if(strcmp(current->name, name) == 0)
            return current;
        current = current->next;
    }
    return NULL;
}

void insert(char *name, char *type) {
    if(lookup(name)) {
        fprintf(stderr, "Error: Variable '%s' already declared\n", name);
        exit(1);
    }
    symtab_entry *entry = malloc(sizeof(symtab_entry));
    entry->name = strdup(name);
    entry->type = strdup(type);
    entry->next = symbol_table;
    symbol_table = entry;
}

/* ---------- Code Generation Helpers ---------- */

int temp_count = 1;
int label_count = 1;

char* new_temp() {
    char *temp = malloc(8);
    sprintf(temp, "t%d", temp_count++);
    return temp;
}

char* new_label() {
    char *label = malloc(8);
    sprintf(label, "L%d", label_count++);
    return label;
}

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char *str;
}

%token <str> ID NUM
%token INT FLOAT
%token TRUE FALSE
%token AND OR NOT
%token IF THEN ELSE WHILE
%token EQ NE LE GE LT GT
%token DO

%type <str> expr relop type var_list
%type <str> stmt stmt_list assign_stmt if_stmt while_stmt

%left OR
%left AND
%right NOT
%nonassoc EQ NE LT LE GT GE
%left '+' '-'
%left '*' '/'

%nonassoc THEN
%nonassoc ELSE
%%

program:
    stmt_list
;

stmt_list:
    stmt_list stmt { if ($2) printf("%s", $2); }
  | stmt           { if ($1) printf("%s", $1); }
;

stmt:
      var_decl     { $$ = NULL; }
    | assign_stmt
    | if_stmt
    | while_stmt
;

var_decl:
    type var_list ';' {
        char *type_name = $1;
        char *vars = $2;
        char *token = strtok(vars, " ");
        while(token) {
            insert(token, type_name);
            printf("Declared %s %s\n", type_name, token);
            token = strtok(NULL, " ");
        }
    }
;

assign_stmt:
    ID '=' expr ';' {
        if (!lookup($1)) {
            fprintf(stderr, "Error: Variable '%s' not declared\n", $1);
            exit(1);
        }
        char *buf = malloc(100);
        sprintf(buf, "%s = %s\n", $1, $3);
        $$ = buf;
    }
;

if_stmt:
    IF expr relop expr THEN stmt ELSE stmt {
        char *L1 = new_label();
        char *L2 = new_label();
        char *L3 = new_label();
        char *Lnext = new_label();

        char *buf = malloc(1000);
        sprintf(buf,
            "%s: if %s %s %s goto %s\n"
            "goto %s\n"
            "%s:\n"
            "%s"
            "goto %s\n"
            "%s:\n"
            "%s"
            "%s:\n",
            L1, $2, $3, $4, L2, L3,
            L2, $6 ? $6 : "", Lnext,
            L3, $8 ? $8 : "", Lnext
        );
        $$ = buf;
    }
  | IF expr relop expr THEN stmt {
        /* if-then without else */
        char *L1 = new_label();
        char *L2 = new_label();
        char *Lnext = new_label();

        char *buf = malloc(1000);
        sprintf(buf,
            "%s: if %s %s %s goto %s\n"
            "goto %s\n"
            "%s:\n"
            "%s"
            "goto %s\n"
            "%s:\n",
            L1, $2, $3, $4, L2, Lnext,
            L2, $6 ? $6 : "", Lnext, Lnext
        );
        $$ = buf;
    }
;

while_stmt:
    WHILE expr relop expr DO stmt {
        char *L1 = new_label();
        char *L2 = new_label();
        char *Lnext = new_label();

        char *buf = malloc(1000);
        sprintf(buf,
            "%s: if %s %s %s goto %s\n"
            "goto %s\n"
            "%s:\n"
            "%s"
            "goto %s\n"
            "%s:\n",
            L1, $2, $3, $4, L2, Lnext,
            L2, $6 ? $6 : "", L1, Lnext
        );
        $$ = buf;
    }
;

type:
    INT   { $$ = strdup("int"); }
  | FLOAT { $$ = strdup("float"); }
;

var_list:
    ID {
        $$ = strdup($1);
    }
  | var_list ',' ID {
        char *temp = malloc(strlen($1) + strlen($3) + 2);
        sprintf(temp, "%s %s", $1, $3);
        free($1);
        $$ = temp;
    }
;

expr:
    expr '+' expr {
        char *temp = new_temp();
        printf("%s = %s + %s\n", temp, $1, $3);
        $$ = temp;
    }
  | expr '-' expr {
        char *temp = new_temp();
        printf("%s = %s - %s\n", temp, $1, $3);
        $$ = temp;
    }
  | expr '*' expr {
        char *temp = new_temp();
        printf("%s = %s * %s\n", temp, $1, $3);
        $$ = temp;
    }
  | expr '/' expr {
        char *temp = new_temp();
        printf("%s = %s / %s\n", temp, $1, $3);
        $$ = temp;
    }
  | '(' expr ')' { $$ = $2; }
  | ID {
        if (!lookup($1)) {
            fprintf(stderr, "Error: Variable '%s' not declared\n", $1);
            exit(1);
        }
        $$ = $1;
    }
  | NUM { $$ = $1; }
;

relop:
    LT { $$ = strdup("<"); }
  | GT { $$ = strdup(">"); }
  | LE { $$ = strdup("<="); }
  | GE { $$ = strdup(">="); }
  | EQ { $$ = strdup("=="); }
  | NE { $$ = strdup("!="); }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter statements:\n");
    yyparse();
    return 0;
}

