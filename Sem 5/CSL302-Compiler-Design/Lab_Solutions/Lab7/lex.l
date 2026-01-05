%{
#include <stdio.h>
#include "y.tab.h" 
extern FILE *yyin;
%}

%%
[ \t\r\n]+                ;   // Ignore whitespace

";".*                    ;   // Ignore comments

":"                      { return COLON; }
","                      { return COMMA; }

"MOV"     { return MOV; }
"ADD"     { return ADD; }
"SUB"     { return SUB; }
"MUL"     { return MUL; }
"DIV"     { return DIV; }
"LOAD"    { return LOAD; }
"STORE"   { return STORE; }
"JMP"     { return JMP; }
"CMP"     { return CMP; }
"HALT"    { return HALT; }

[R][0-9]                 { return REGISTER; }

[#]-?[0-9]+              { return IMMEDIATE; }

[A-Z]+          { return LABEL; }

.                        { return ERROR; }

%%

int yywrap(void) { return 1; }

