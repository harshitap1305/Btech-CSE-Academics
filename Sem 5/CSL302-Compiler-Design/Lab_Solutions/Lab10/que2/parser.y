%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h> 

/* ------------ Symbol Table ------------ */
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

/* ------------ Temporary / Label Helpers ------------ */
int temp_count = 1;
int label_count = 1;
int instr_count = 0;

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

/* ------------ Backpatching Support ------------ */
typedef struct list {
    int instr;
    struct list *next;
} List;

List* makelist(int i) {
    List *l = (List*) malloc(sizeof(List));
    l->instr = i;
    l->next = NULL;
    return l;
}

List* merge(List *l1, List *l2) {
    if (!l1) return l2;
    List *t = l1;
    while (t->next) t = t->next;
    t->next = l2;
    return l1;
}

void backpatch(List *l, char *label) {
    while (l) {
        printf(" (backpatch %d -> %s)\n", l->instr, label);
        l = l->next;
    }
}

/* bookkeeping */
void emit(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    printf("%3d: ", ++instr_count);
    vprintf(fmt, args);
    printf("\n");
    va_end(args);
}

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char *str;
    struct {
        char *addr;
        struct list *truelist;
        struct list *falselist;
        struct list *nextlist;
        char *label;
    } code;
}

%token <str> ID NUM
%token INT FLOAT
%token TRUE FALSE
%token AND OR NOT
%token IF THEN ELSE WHILE DO
%token EQ NE LE GE LT GT

%type <code> expr bool stmt stmt_list if_stmt while_stmt M func_call arg_list
%type <str> type var_list relop

%left OR
%left AND
%right NOT
%nonassoc EQ NE LT LE GT GE
%left '+' '-'
%left '*' '/'

%%

program:
    stmt_list
;

stmt_list:
      stmt_list stmt
    | stmt
;

stmt:
      var_decl        { $$.nextlist = NULL; }
    | assign_stmt     { $$.nextlist = NULL; }
    | if_stmt         { $$.nextlist = $1.nextlist; }
    | while_stmt      { $$.nextlist = $1.nextlist; }
    | func_call ';'   { $$.nextlist = NULL; }
;


var_decl:
    type var_list ';' {
        char *type_name = $1;
        char *vars = $2;
        char *tok = strtok(vars, " ");
        while(tok) {
            insert(tok, type_name);
            printf("Declared %s %s\n", type_name, tok);
            tok = strtok(NULL, " ");
        }
    }
;

assign_stmt:
    ID '=' expr ';' {
        if (!lookup($1)) {
            fprintf(stderr, "Error: Variable '%s' not declared\n", $1);
            exit(1);
        }
        emit("%s = %s", $1, $3.addr);
    }
;

if_stmt:
    IF bool THEN M stmt {
        backpatch($2.truelist, $4.label);
        $$ .nextlist = merge($2.falselist, $5.nextlist);
    }
  | IF bool THEN M stmt ELSE M stmt {
        backpatch($2.truelist, $4.label);
        backpatch($2.falselist, $7.label);
        $$ .nextlist = merge($5.nextlist, $8.nextlist);
    }
;

while_stmt:
    WHILE M bool DO M stmt {
        backpatch($3.truelist, $5.label);
        emit("goto %s", $2.label);
        $$ .nextlist = $3.falselist;
    }
;

expr:
    expr '+' expr {
        char *t = new_temp();
        emit("%s = %s + %s", t, $1.addr, $3.addr);
        $$.addr = t;
    }
  | expr '-' expr {
        char *t = new_temp();
        emit("%s = %s - %s", t, $1.addr, $3.addr);
        $$.addr = t;
    }
  | expr '*' expr {
        char *t = new_temp();
        emit("%s = %s * %s", t, $1.addr, $3.addr);
        $$.addr = t;
    }
  | expr '/' expr {
        char *t = new_temp();
        emit("%s = %s / %s", t, $1.addr, $3.addr);
        $$.addr = t;
    }
  | '(' expr ')' { $$.addr = $2.addr; }
  | ID {
        if (!lookup($1)) {
            fprintf(stderr, "Error: Variable '%s' not declared\n", $1);
            exit(1);
        }
        $$.addr = $1;
    }
  | NUM { $$.addr = $1; }
;

bool:
    expr relop expr {
        emit("if %s %s %s goto _", $1.addr, $2, $3.addr);
        emit("goto _");
        $$.truelist = makelist(instr_count - 1);
        $$.falselist = makelist(instr_count);
    }
  | bool AND M bool {
        backpatch($1.truelist, $3.label);
        $$.truelist = $4.truelist;
        $$.falselist = merge($1.falselist, $4.falselist);
    }
  | bool OR M bool {
        backpatch($1.falselist, $3.label);
        $$.truelist = merge($1.truelist, $4.truelist);
        $$.falselist = $4.falselist;
    }
  | NOT bool {
        $$.truelist = $2.falselist;
        $$.falselist = $2.truelist;
    }
  | TRUE {
        emit("goto _");
        $$.truelist = makelist(instr_count);
        $$.falselist = NULL;
    }
  | FALSE {
        emit("goto _");
        $$.truelist = NULL;
        $$.falselist = makelist(instr_count);
    }
;

M:
    { 
      $$.label = new_label();
      printf("%s:\n", $$.label);
    }
;

relop:
    LT { $$ = strdup("<"); }
  | GT { $$ = strdup(">"); }
  | LE { $$ = strdup("<="); }
  | GE { $$ = strdup(">="); }
  | EQ { $$ = strdup("=="); }
  | NE { $$ = strdup("!="); }
;

type:
    INT   { $$ = strdup("int"); }
  | FLOAT { $$ = strdup("float"); }
;

var_list:
    ID { $$ = strdup($1); }
  | var_list ',' ID {
        char *tmp = malloc(strlen($1) + strlen($3) + 2);
        sprintf(tmp, "%s %s", $1, $3);
        $$ = tmp;
    }
;

/* ---------- Function Call Support ---------- */
func_call:
    ID '(' arg_list ')' {
        printf("Function call: %s(", $1);
        List *arg_instrs = NULL;
        if ($3.addr) {
            char *args = $3.addr;
            printf("%s", args);
        }
        printf(")\n");
        emit("call %s, %s", $1, $3.addr ? $3.addr : ""); 
        $$.addr = ""; // not storing return value for now
    }
;

arg_list:
      /* empty */ { $$.addr = NULL; }
    | expr {
        $$.addr = strdup($1.addr);
    }
    | arg_list ',' expr {
        char *tmp = malloc(strlen($1.addr) + strlen($3.addr) + 2);
        sprintf(tmp, "%s,%s", $1.addr, $3.addr);
        $$.addr = tmp;
    }
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

