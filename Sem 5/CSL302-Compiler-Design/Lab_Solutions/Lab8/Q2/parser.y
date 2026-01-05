%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct symtab_entry {
    char *name;
    char *type;
    struct symtab_entry *next;
} symtab_entry;

symtab_entry *symbol_table = NULL;

void yyerror(const char *s);
int yylex(void);


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
        char err[100];
        sprintf(err, "Variable '%s' already declared", name);
        yyerror(err);
        exit(1);
    }
    symtab_entry *entry = (symtab_entry *) malloc(sizeof(symtab_entry));
    entry->name = strdup(name);
    entry->type = strdup(type);
    entry->next = symbol_table;
    symbol_table = entry;
}

int temp_count = 1;
char* new_temp() {
    char *temp = (char*)malloc(5);
    sprintf(temp, "t%d", temp_count++);
    return temp;
}
%}

%union {
    char *str;
}

%token <str> ID NUM
%token INT FLOAT
%token TRUE FALSE
%token AND OR NOT
%token EQ NE LE GE LT GT

%type <str> expr relop type var_list

%left OR
%left AND
%right NOT
%nonassoc EQ NE LT LE GT GE
%left '+' '-'
%left '*' '/'

%%

program:
      program stmt
    | /* empty */
    ;

stmt:
      var_decl
    | ID '=' expr {
          printf("%s = %s\n", $1, $3);
      }
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

type:
      INT { $$ = strdup("int"); }
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
    | expr relop expr {
          char *temp = new_temp();
          printf("%s = %s %s %s\n", temp, $1, $2, $3);
          $$ = temp;
      }
    | expr AND expr {
          char *temp = new_temp();
          printf("%s = %s and %s\n", temp, $1, $3);
          $$ = temp;
      }
    | expr OR expr {
          char *temp = new_temp();
          printf("%s = %s or %s\n", temp, $1, $3);
          $$ = temp;
      }
    | NOT expr {
          char *temp = new_temp();
          printf("%s = not %s\n", temp, $2);
          $$ = temp;
      }
    | '(' expr ')' { $$ = $2; }
    | TRUE { $$ = strdup("true"); }
    | FALSE { $$ = strdup("false"); }
    | ID { $$ = $1; }
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

