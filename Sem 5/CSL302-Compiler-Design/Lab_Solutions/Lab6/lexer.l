%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

digit       [0-9]
id          [a-zA-Z_][a-zA-Z0-9_]*
ws          [ \t\n]+

%%

"int"           { return INT; }
"float"         { return FLOAT; }
"for"           { return FOR; }
"if"            { return IF; }
"then"          { return THEN; }
"else"          { return ELSE; }
"elif"          { return ELIF; }
"switch"        { return SWITCH; }
"case"          { return CASE; }
"while"         { return WHILE; }
"do"            { return DO; }

{digit}+        { yylval.num = atoi(yytext); return NUMBER; }
{id}            { yylval.id = strdup(yytext); return ID; }

"=="            { return EQ; }
"!="            { return NE; }
"<="            { return LE; }
">="            { return GE; }
"<"             { return '<'; }
">"             { return '>'; }

"="             { return '='; }
";"             { return ';'; }
","             { return ','; }
"("             { return '('; }
")"             { return ')'; }
"{"             { return '{'; }
"}"             { return '}'; }
":"             { return ':'; }

"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"%"             { return '%'; }

{ws}            ;   /* skip whitespace */

.               { return yytext[0]; }  /* any other char */

%%

int yywrap() { return 1; }

