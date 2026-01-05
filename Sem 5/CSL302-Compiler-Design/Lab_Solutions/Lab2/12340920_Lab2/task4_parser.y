%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
extern int lines, words, chars;
extern FILE *yyin;
%}

%token END
%%
input:
      END   { /* lexer ran through everything */ }
    ;
%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    yyparse();
    fclose(file);

    printf("%d %d %d %s\n", lines, words, chars, argv[1]);
    return 0;
}

