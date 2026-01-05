%{
#include <stdio.h>
%}

%%

\#define   {printf("%s: TOKEN_KEYWORD_DEFINE\n", yytext);}
\#include  {printf("%s: TOKEN_KEYWORD_INCLUDE\n", yytext);}
\#ifdef    {printf("%s: TOKEN_KEYWORD_IFDEF\n", yytext);}
\#ifndef   {printf("%s: TOKEN_KEYWORD_IFNDEF\n", yytext);}
\#if       {printf("%s: TOKEN_KEYWORD_IF\n", yytext);}
\#else     {printf("%s: TOKEN_KEYWORD_ELSE\n", yytext);}
\#elif     {printf("%s: TOKEN_KEYWORD_ELIF\n", yytext);}
\#endif    {printf("%s: TOKEN_KEYWORD_ENDIF\n", yytext);}
\#undef    {printf("%s: TOKEN_KEYWORD_UNDEF\n", yytext);}
\#pragma   {printf("%s: TOKEN_KEYWORD_PRAGMA\n", yytext);}
\#error    {printf("%s: TOKEN_KEYWORD_ERROR\n", yytext);}
\#line     {printf("%s: TOKEN_KEYWORD_LINE\n", yytext);}


\"([^"\n]*)\"  { printf("%s: TOKEN_STRING_LITERAL\n", yytext); }


[a-zA-Z0-9_]+\.h  { printf("%s: TOKEN_FILE_HEADER\n", yytext); }
[a-zA-Z0-9_]+\.c  { printf("%s: TOKEN_FILE_SOURCE\n", yytext); }


0[xX][0-9a-fA-F]+  { printf("%s: TOKEN_HEX\n", yytext); }
[0-9]+\.[0-9]+     { printf("%s: TOKEN_FLOAT\n", yytext); }
[0-9]+             { printf("%s: TOKEN_INTEGER\n", yytext); }


"=="|"+"|"-"|"*"|"/" { printf("%s: TOKEN_OPERATOR\n", yytext); }


@@[^\n]*            { printf("%s: TOKEN_SINGLE_LINE_COMMENT\n", yytext); }
\"\"\"(.|\n)*?\"\"\"  { printf("%s: TOKEN_MULTI_LINE_COMMENT\n", yytext); }


\$[A-Z][A-Za-z0-9_]*  { printf("%s: TOKEN_IDENTIFIER\n", yytext); }

[\t\n ]+  ;

.  { printf("%s: UNRECOGNIZED\n", yytext); }

%%

int yywrap() { return 1; }

int main(int argc, char* argv[]) {
    if(argc != 2) {
        printf("wrong number of input");
        return 1;
    }
    FILE *file = fopen(argv[1],"r");
    if(!file) {
        printf("Error opening the file\n");
        return 1;
    }
    yyin = file;
    yylex();
    fclose(file);
    return 0;
}

