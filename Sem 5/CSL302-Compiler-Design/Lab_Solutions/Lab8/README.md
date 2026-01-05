README FILE FOR LAB 8

# Task 2:

## Part 1:
Files: lexer.l , parser.y

### How to execute:

lex lexer.l
yacc -d parser.y
gcc lex.yy.c y.tab.c
./a.out 

### Sample input

##### Correct input:
a=b+c
x=4
b = a and c
a = c or d
a = true
 
#### Incorrect input:
a and c
a = b+c;



## Part 2:
Files: lexer.l , parser.y

### How to execute:

lex lexer.l
yacc -d parser.y
gcc lex.yy.c y.tab.c
./a.out 

### Sample input

##### Correct input:
int a, b, c; float x, y;

 
#### Incorrect input:
int a, b, c; float x, a;

