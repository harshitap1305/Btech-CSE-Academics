# README Lab4

## Question 1: Implementation of Linux Commands Using Lexical Analysis

### Description
This Lex program implements simplified versions of the following Linux commands:
- `head` : Prints the first N lines of a file (default 10 lines). Supports `-n` option or `-5` style arguments.
- `tail` : Prints the last N lines of a file (default 10 lines). Supports `-n` option or `-5` style arguments.
- `cat`  : Prints the entire content of a file.
- `cp`   : Copies the contents of one file to another.

The program takes commands as input lines, lexically analyzes them, and executes the corresponding functionality.

### How to run

lex que1.l
gcc lex.yy.c
./a.out

#### for testing enter this commands
 
head example.txt
head -n 5 example.txt
head -5 example.txt
tail example.txt
tail -n 3 example.txt
tail -7 example.txt
cat example.txt
cp example.txt destination.txt


## Question 2: File/Directory Path Validator Using Lexical Analysis

### Description
This Lex program reads file or directory paths and checks if they are valid based on the rules given in question:


### How to run
lex que1.l
gcc lex.yy.c
./a.out

#### for testing enter any paths, eg:

/home/user/docs/file.txt
/home/../root/data.dat
/invalid/path/file.doc
home
//home;hi
