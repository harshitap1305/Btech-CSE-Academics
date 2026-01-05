%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%
"int"           { return INT; }
"float"         { return FLOAT; }
"true"          { yylval.str = strdup("true"); return TRUE; }
"false"         { yylval.str = strdup("false"); return FALSE; }
"and"           { return AND; }
"or"            { return OR; }
"not"           { return NOT; }
"=="            { return EQ; }
"!="            { return NE; }
"<="            { return LE; }
">="            { return GE; }
"<"             { return LT; }
">"             { return GT; }
[0-9]+          { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }
[ \t]+          ;  /* ignore whitespace */
\n              { return 0; } /* EOF */
";"             { return ';'; }
","             { return ','; }
.               { return yytext[0]; }
%%
int yywrap() { return 1; }

