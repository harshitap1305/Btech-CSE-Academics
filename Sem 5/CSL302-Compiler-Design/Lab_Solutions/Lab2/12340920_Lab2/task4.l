%{
#include <stdio.h>
#include "y.tab.h"

int words = 0;
int chars = 0;
int lines = 0;
%}

%%
\n              { lines++; chars++; }
[ \t\r\f]+      { chars += yyleng; }          
[^ \t\r\n\f]+   { words++; chars += yyleng; }
<<EOF>>         { return END; }   /* signal end of input to parser */
%%
int yywrap() { return 1; }

