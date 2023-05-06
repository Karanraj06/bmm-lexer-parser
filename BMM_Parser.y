%{
#include <stdio.h>
#include <string.h>
int yylex(void);
int yyparse(void);
void yyerror(char *s);
%}

%union {
    int num;
    char *str;
}

%token <num> lineNum
%token <str> comment let print If then var data end stop

%%
// program : lineNum comment
//         | lineNum statement {}
//         ;

program : ""
%%