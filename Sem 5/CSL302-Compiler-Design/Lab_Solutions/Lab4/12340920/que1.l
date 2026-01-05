%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include<ctype.h>
#define MAX_ARGS 50

char *args[MAX_ARGS];
int arg_count = 0;

// Function declarations
void run_head(int n, char *filename);
void run_tail(int n, char *filename);
void run_cat(char *filename);
void run_cp(char *src, char *dst);

%}

%%
[ \t]+           ;               /* ignore whitespace */
\n               { 
                    if (arg_count > 0) {
                        // Process command with args
                        if (strcmp(args[0], "head") == 0) {
                            int n = 10;
                            char *filename = NULL;
                            for (int i = 1; i < arg_count; i++) {
                                if (strcmp(args[i], "-n") == 0 && i+1 < arg_count) {
                                    n = atoi(args[i+1]);
                                    i++;
                                } else if (args[i][0]=='-' && isdigit(args[i][1])){
                                     n=atoi(args[i]+1);
                                }
                                else {
                                    filename = args[i];
                                }
                            }
                            if (filename) run_head(n, filename);
                        }
                        else if (strcmp(args[0], "tail") == 0) {
                            int n = 10;
                            char *filename = NULL;
                            for (int i = 1; i < arg_count; i++) {
                                if (strcmp(args[i], "-n") == 0 && i+1 < arg_count) {
                                    n = atoi(args[i+1]);
                                    i++;
                                } else if (args[i][0]=='-' && isdigit(args[i][1])){
                                     n=atoi(args[i]+1);
                                } else {
                                    filename = args[i];
                                }
                            }
                            if (filename) run_tail(n, filename);
                        }
                        else if (strcmp(args[0], "cat") == 0) {
                            if (arg_count > 1)
                                run_cat(args[1]);
                        }
                        else if (strcmp(args[0], "cp") == 0) {
                            if (arg_count > 2)
                                run_cp(args[1], args[2]);
                        } else {
                            printf("Unknown command: %s\n", args[0]);
                        }
                        arg_count = 0; // reset for next line
                    }
                }
"-"[0-9]+ {
  if(arg_count < MAX_ARGS){
    args[arg_count++]=strdup(yytext);
  }
  }
[a-zA-Z0-9_\-./]+ {
                    if (arg_count < MAX_ARGS) {
                        args[arg_count++] = strdup(yytext);
                    }
                }
.               ;  /* ignore any other char */

%%

void run_head(int n, char *filename) {
    FILE *f = fopen(filename, "r");
    if (!f) {
        perror("head");
        return;
    }
    char line[1024];
    int count = 0;
    while (fgets(line, sizeof(line), f) && count < n) {
        printf("%s", line);
        count++;
    }
    fclose(f);
}

void run_tail(int n, char *filename) {
    FILE *f = fopen(filename, "r");
    if (!f) {
        perror("tail");
        return;
    }
    char **lines = malloc(n * sizeof(char *));
    if (!lines) {
        perror("malloc");
        fclose(f);
        return;
    }
    for (int i = 0; i < n; i++) lines[i] = NULL;

    int count = 0;
    char buffer[1024];
    while (fgets(buffer, sizeof(buffer), f)) {
        if (lines[count % n]) free(lines[count % n]);
        lines[count % n] = strdup(buffer);
        count++;
    }

    int start = count > n ? count % n : 0;
    int print_count = count < n ? count : n;

    for (int i = 0; i < print_count; i++) {
        printf("%s", lines[(start + i) % n]);
        free(lines[(start + i) % n]);
    }
    free(lines);
    fclose(f);
}

void run_cat(char *filename) {
    FILE *f = fopen(filename, "r");
    if (!f) {
        perror("cat");
        return;
    }
    int c;
    while ((c = fgetc(f)) != EOF) {
        putchar(c);
    }
    fclose(f);
}

void run_cp(char *src, char *dst) {
    FILE *fsrc = fopen(src, "rb");
    if (!fsrc) {
        perror("cp source");
        return;
    }
    FILE *fdst = fopen(dst, "wb");
    if (!fdst) {
        perror("cp destination");
        fclose(fsrc);
        return;
    }

    char buf[4096];
    size_t n;
    while ((n = fread(buf, 1, sizeof(buf), fsrc)) > 0) {
        fwrite(buf, 1, n, fdst);
    }
    fclose(fsrc);
    fclose(fdst);
}

int yywrap(void) {
    return 1;
}

int main() {
    yylex();
    return 0;
}
