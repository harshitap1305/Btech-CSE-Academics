%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

int error_flag = 0;
%}

%token MOV ADD SUB MUL DIV LOAD STORE JMP CMP HALT
%token REGISTER IMMEDIATE LABEL
%token COLON COMMA
%token ERROR

%%

program:
    lines
    ;

lines:
    /* empty */
    | lines line
    ;

line:
      instruction
    | label_def instruction 
    ;

label_def:
    LABEL COLON
    ;

instruction:
      MOV REGISTER COMMA operand
    | ADD REGISTER COMMA operand
    | SUB REGISTER COMMA operand
    | MUL REGISTER COMMA operand
    | DIV REGISTER COMMA operand
    | LOAD REGISTER COMMA operand
    | STORE REGISTER COMMA operand
    | CMP REGISTER COMMA operand
    | JMP LABEL
    | HALT
    ;

operand:
      REGISTER
    | IMMEDIATE
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
    error_flag = 1;
}

int main(void) {
    printf("Running Syntax Analyzer...\n");
    if (yyparse() == 0 && !error_flag) {
        printf("The program is syntactically correct.\n");
    } else {
        printf("The program has syntax errors.\n");
    }
    return 0;
}

