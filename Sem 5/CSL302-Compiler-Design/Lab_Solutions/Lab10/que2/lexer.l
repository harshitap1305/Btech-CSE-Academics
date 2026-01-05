%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

DIGIT   [0-9]
ID      [a-zA-Z_][a-zA-Z0-9_]*

%%

"int"           { return INT; }
"float"         { return FLOAT; }
"true"          { return TRUE; }
"false"         { return FALSE; }
"if"            { return IF; }
"then"          { return THEN; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"do"            { return DO; }
"and"           { return AND; }
"or"            { return OR; }
"not"           { return NOT; }

"=="            { return EQ; }
"!="            { return NE; }
"<="            { return LE; }
">="            { return GE; }

"="             { return '='; }
";"             { return ';'; }
","             { return ','; }
"("             { return '('; }
")"             { return ')'; }
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"<"             { return LT; }
">"             { return GT; }

{DIGIT}+        { yylval.str = strdup(yytext); return NUM; }
{ID}            { yylval.str = strdup(yytext); return ID; }

[ \t\n]+        { /* skip whitespace */ }

.               { return yytext[0]; }

%%

int yywrap(void) 
{ return 1;}

