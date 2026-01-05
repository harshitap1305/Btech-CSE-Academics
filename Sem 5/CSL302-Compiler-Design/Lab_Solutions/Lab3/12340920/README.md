files: README.md, 12340920_lab3.l, example.txt

description: 
Lexical analyzer for a subset of the C preprocessor that recognizes keywords, strings, file names, numbers, operators, comments, and identifiers, and prints corresponding tokens.

how to run:
flex 12340290_lab3.l
gcc lex.yy.c -o lexer
./lexer example.txt


