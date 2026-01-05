%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int temp_count = 1;
char* new_temp() {
    char *temp = (char*)malloc(5);
    sprintf(temp, "t%d", temp_count++);
    return temp;
}

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char *str;
}

%token <str> ID NUM
%token TRUE FALSE
%token AND OR NOT
%token EQ NE LE GE LT GT

%type <str> expr relop

%left OR
%left AND
%right NOT
%nonassoc EQ NE LT LE GT GE
%left '+' '-'
%left '*' '/'

%%

program:
      stmt
    | program stmt
    ;

stmt:
      ID '=' expr {
          printf("%s = %s\n", $1, $3);
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
    printf("Enter expression (e.g., a < b or not c):\n");
    yyparse();
    return 0;
}

