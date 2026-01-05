%{
#include "y.tab.h"
#include <string.h>
%}

%%
"for"           { return FOR; }
[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.id = strdup(yytext); return ID; }
"="             { return '='; }
";"             { return ';'; }
"("             { return '('; }
")"             { return ')'; }
"*"             { return '*'; }
"/"             { return '/'; }
"%"             { return '%'; }
"+"             { return '+'; }
"-"             { return '-'; }
[ \t\n]         ;   /* skip spaces */
.               { return yytext[0]; }
%%

int yywrap() { return 1; }

