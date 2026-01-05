# ReadMe

## Description
This program reads a file and extracts:
- Keywords: foreach, echo, read
- Identifiers: start with '_', end with digit, middle chars lowercase letters

## Compile
gcc program.c -o extractor

## Run
./extractor input.txt

## Output
Lists keywords first, then identifiers found in the file.

