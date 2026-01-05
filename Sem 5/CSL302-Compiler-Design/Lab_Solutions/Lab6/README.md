# README - Lab 6 (Syntax Analysis)

### Instructions to Execute

1. Extract the zip file.
2. Open a terminal inside the extracted folder.
3. Run the following commands:
   ```bash
   lex lexer.l
   yacc -d yacc.y
   gcc lex.yy.c y.tab.c 
   ./a.out eg.txt
   ```
   
- eg.txt contains all the examples as per the rules and syntax given/asked in the question
