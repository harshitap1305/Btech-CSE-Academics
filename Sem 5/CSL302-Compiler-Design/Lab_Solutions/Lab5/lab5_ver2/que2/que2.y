%{
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>

   int flag = 0;

   /* --- symbol table --- */
   typedef struct Symbol {
      char *name;
      int value;
      struct Symbol *next;
   } Symbol;

   Symbol *symtab = NULL;

   /* find symbol in table */
   Symbol* lookup(char *name) {
      Symbol *s = symtab;
      while(s) {
         if(strcmp(s->name, name) == 0) return s;
         s = s->next;
      }
      return NULL;
   }

   /* insert/update symbol */
   void assign(char *name, int val) {
      Symbol *s = lookup(name);
      if(s) {
         s->value = val;
      } else {
         s = (Symbol*)malloc(sizeof(Symbol));
         s->name = strdup(name);
         s->value = val;
         s->next = symtab;
         symtab = s;
      }
   }

   int getval(char *name) {
      Symbol *s = lookup(name);
      if(s) return s->value;
      return 0;   /* default 0 if not assigned */
   }
%}

%union {
   int num;
   char* id;
}

%start STMTS
%token <num> NUMBER
%token <id> ID
%type <num> E

%left '*' '/' '%'
%left '+' '-'
%left '(' ')'
%right '='

%%
STMTS : STMTS ';' STMT
      | STMT
      ;

STMT  : ID '=' E   {
                      assign($1, $3);
                      printf("Assignment: %s = %d\n", $1, $3);
                      free($1);
                   }
      | E          { printf("Expression Result = %d\n", $1); }
      ;

E     : E '+' E    { $$ = $1 + $3; }
      | E '-' E    { $$ = $1 - $3; }
      | E '*' E    { $$ = $1 * $3; }
      | E '/' E    { $$ = $1 / $3; }
      | E '%' E    { $$ = $1 % $3; }
      | '(' E ')'  { $$ = $2; }
      | NUMBER     { $$ = $1; }
      | ID         {
                      $$ = getval($1);
                      free($1);
                   }
      ;
%%

int main() {
   printf("\nEnter statements (assignments/expressions) separated by ';':\n");
   yyparse();
   if(flag==0)
      printf("\nEntered input is Valid\n\n");
   return 0;
}

void yyerror(const char* s) {
   printf("\nEntered input is Invalid\n\n");
   flag=1;
}

