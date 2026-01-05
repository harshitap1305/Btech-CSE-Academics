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

   Symbol* lookup(char *name) {
      Symbol *s = symtab;
      while(s) {
         if(strcmp(s->name, name) == 0) return s;
         s = s->next;
      }
      return NULL;
   }

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
%token FOR
%type <num> E B

%left '*' '/' '%'
%left '+' '-'
%left '<' '>' LE GE EQ NE
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
      | FOR '(' STMT ';' B ';' STMT ')' STMT
                   {
                      printf("For loop detected (init, cond, step)\n");
                   }
      ;

/* Boolean / relational expressions */
B     : E '<' E    { $$ = $1 < $3; }
      | E '>' E    { $$ = $1 > $3; }
      | E LE  E    { $$ = $1 <= $3; }
      | E GE  E    { $$ = $1 >= $3; }
      | E EQ  E    { $$ = $1 == $3; }
      | E NE  E    { $$ = $1 != $3; }
      | E          { $$ = $1; }   /* allow arithmetic as boolean */
      ;

/* Arithmetic expressions */
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
   printf("\nEnter statements (assignments/expressions/for-loops) separated by ';':\n");
   yyparse();
   if(flag==0)
      printf("\nEntered input is Valid\n\n");
   return 0;
}

void yyerror(const char* s) {
   printf("\nEntered input is Invalid\n\n");
   flag=1;
}

