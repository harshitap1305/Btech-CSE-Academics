%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int is_valid_path=1;

void validate_component(char *comp) {
    
    int len = strlen(comp);

    if (strcmp(comp, "..")==0) {
        return;
    }

    char *dot = strrchr(comp, '.');
    if (dot) {

        char *ext = dot + 1;
        if (strcmp(ext, "txt")!=0 &&strcmp(ext,"dat")!=0){
            is_valid_path=0;  
            return;
        }
        for (int i=0; i<dot-comp;i++) {
            if (!isalnum(comp[i])) {
                is_valid_path = 0;
                return;
            }
        }
    } else {
        for (int i=0;i<len;i++) {
            if (!isalnum(comp[i])) {
                is_valid_path = 0;
                return;
            }
        }
    }
}
%}

%%
.|\n {
    static char input[1024];
    static int pos = 0;

    if (pos==0) memset(input,0,sizeof(input));

    if (yytext[0]!='\n') {
        strcat(input, yytext);
    } else {
        is_valid_path = 1;
        if (input[0] != '/') {
            is_valid_path = 0;
        } else {
            char *copy = strdup(input);
            char *token = strtok(copy, "/");

            while (token != NULL && is_valid_path) {
                if (strlen(token) > 0)
                    validate_component(token);
                token = strtok(NULL, "/");
            }
            free(copy);
        }

        if (is_valid_path) {
            printf("VALID PATH\n");
        } else {
            printf("INVALID PATH\n");
        }

        pos = 0; 
        return 0; 
    }
    pos += yyleng;
}
%%
int yywrap(void)
{return 1;}
int main() {
    yylex();
    return 0;
}

