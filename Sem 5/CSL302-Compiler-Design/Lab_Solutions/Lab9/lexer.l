%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%
"int"           { return INT; }
"float"         { return FLOAT; }
"if"            { return IF; }
"then"          { return THEN; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"do"            { return DO; }
"=="            { return EQ; }
"!="            { return NE; }
"<="            { return LE; }
">="            { return GE; }
"<"             { return LT; }
">"             { return GT; }
[0-9]+          { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }
[ \t\r\n]+      ;
";"             { return ';'; }
","             { return ','; }
.               { return yytext[0]; }
%%
int yywrap() { return 1; }

