%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

/* Token declarations: must match your .l file */
%token NAME PHONE_NUMBER EMAIL CREDIT_CARD DOB

%%
input:
    /* empty */
    | input token '\n'
    ;

token:
      NAME          { printf("→ Recognized token: NAME\n"); }
    | PHONE_NUMBER  { printf("→ Recognized token: PHONE_NUMBER\n"); }
    | EMAIL         { printf("→ Recognized token: EMAIL\n"); }
    | CREDIT_CARD   { printf("→ Recognized token: CREDIT_CARD\n"); }
    | DOB           { printf("→ Recognized token: DOB\n"); }
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter strings (Ctrl+D to stop):\n");
    yyparse();
    return 0;
}

