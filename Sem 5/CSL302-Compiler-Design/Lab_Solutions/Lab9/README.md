# CSL302 – Compiler Design
## Lab 9 – Intermediate Code Generation (Three Address Code)

### FILES: 

- parser.y -> Yacc grammar for syntax analysis and TAC generation
- lexer.l  -> Lexical analyzer
- README.md  -> Instructions and examples (curr file)

### How to Compile and Run

lex lexer.l
yacc -d parser.y
gcc lex.yy.c y.tab.c
./a.out

### Examples (Syntactically Correct)

1. Example 1:

int x,y,z,c,d;
if c<d then x=y+z; else x=y-z;

2. Example 2: 

int a,b;
while a<b do a=a+1;

3. Example 3:

int a,b,c,d,x,y,z;
while a < b do
if c<d then x=y+z;
else x=y-z;


