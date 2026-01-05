README for CSL302 Lab-7: Syntax Analyzer

Files:
- lex.l       : Lexical analyzer source file
- yacc.y      : Syntax analyzer source file (YACC file)
- eg.txt     : Sample input file

Instructions to build and run:

1. lex lex.l
2. yacc -d yacc.y
3. gcc lex.yy.c y.tab.c 
4. ./a.out < eg.txt

Expected Output:
- If syntax is correct:
  "The program is syntactically correct."
- Otherwise:
  "The program has syntax errors."



