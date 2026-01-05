%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%token INT FLOAT CHAR
%token IDENTIFIER
%token COMMA SEMICOLON


%union {
    char* str;
}

%start program

%type <str> IDENTIFIER
%type <str> datatype
%type <str> id_list
%type <str> declaration


%%
program:
    declarations
    ;

declarations:
    declarations declaration
    | declaration
    ;

declaration:
    datatype id_list SEMICOLON
    {
      printf("Declared variables of type %s:\n", $1);
        printf("%s", $2);
        free($1);
        free($2);
    }
    ;
    
id_list:
    IDENTIFIER 
      {
       char buf[256];
        snprintf(buf, sizeof(buf), "- %s\n", $1);
        $$ = strdup(buf);
        free($1);
      }
    | id_list COMMA IDENTIFIER
      {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s- %s\n", $1, $3);
        $$ = strdup(buf);
        free($1);
        free($3);
      }
     ;

datatype:
    INT     { $$ = strdup("int"); }
    | FLOAT { $$ = strdup("float"); }
    | CHAR  { $$ = strdup("char"); }
    ;
%%

int main() {
    printf("Enter variable declarations:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

