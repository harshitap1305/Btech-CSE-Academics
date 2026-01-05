### Que 1;

## Overview
The grammar supports both `int` and `float` datatypes, along with multiple identifiers separated by commas and ending with a semicolon.

---
## Compilation & Execution
run this commands

```bash
lex var_decl.l
yacc -d var_decl.y
gcc lex.yy.c y.tab.c
./a.out
```

Now test with this inputs: 

Valid inputs:
```bash
int a;
int a,b,c;
float x,y,z;
```
Invalid Input:
```bash
int ;
int a b;
float ,d;
a=5+;
```


### Que 2;

## Overview
The program evaluates the given input and prints the results of assignments.  
If the input is invalid then prints Invalid and stops

---
## Compilation & Execution
run this commands

```bash
lex que2.l
yacc -d que2.y
gcc lex.yy.c y.tab.c
./a.out
```

Now test with this inputs: 

Valid inputs:
```bash
x=5+4; y=x*2-3; total=y+10;
a=b+c+d*f/y
```
Invalid Input:
```bash
b+d=a+c;
a=5+;
```

### Que 3;

## Overview
It recognizes arithmetic expressions, assignment statements, and `for` loop constructs, and checks whether the given input is syntactically valid according to simplified rules given in que. 

---
## Compilation & Execution
run this commands

```bash
lex que3.l
yacc -d que3.y
gcc lex.yy.c y.tab.c
./a.out
```

Now test with this inputs: 

Valid inputs:
```bash
for (i = 0; i < 3; i = i + 1) y = y + 2;
```
Invalid Input:
```bash
for (a + ; 3; b = 2) x = 1;
a=5+;
```


 




 


