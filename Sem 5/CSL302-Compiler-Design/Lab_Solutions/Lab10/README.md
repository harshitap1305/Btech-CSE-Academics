## Lab 10: Intermediate Code Generation

### Folder Structure
12340920_Lab10/
│── README.md
│
├── que1/       ← Part 1: TAC + Backpatching (boolean, if/then/else, while)
│   ├── lexer.l
│   └── parser.y
│
└── que2/       ← Part 2: TAC for Function Invocation (extended part1)
    ├── lexer.l
    └── parser.y
    
### How to compile and run

- For que 1:

    cd que1
    lex lexer.l
    yacc -d parser.y
    gcc lex.yy.c y.tab.c -o que1
    ./que1
    
- For que 2:

    cd que2
    lex lexer.l
    yacc -d parser.y
    gcc lex.yy.c y.tab.c -o que2
    ./que2
    
    
#### Example to run

- part 1

int a, b, c;
a = 10;
b = 20;
c = a + b;

if a < b then
    c = c + 1;
else
    c = c - 1;

while a < c do
    a = a + 1;


- part 2

int x, y, z;
x = 3;
y = 5;
z = x + y;
sum(x, y, z);


