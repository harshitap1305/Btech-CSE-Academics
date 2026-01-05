%{
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>
   #include "y.tab.h"
%}

%%
[0-9]+   { yylval.num = atoi(yytext); return NUMBER; }

[a-zA-Z_][a-zA-Z0-9_]* {
             yylval.id = strdup(yytext);
             return ID;
          }

";"      return ';';
"="      return '=';
[ \t\n]  ;     /* ignore whitespace & newline */
.        return yytext[0];
%%

int yywrap() { return 1; }

