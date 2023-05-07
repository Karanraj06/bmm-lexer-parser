
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char* yytext;
extern FILE* yyin;
extern FILE* yyout;

extern int yylex();
extern int yyparse();

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        printf("Failed to open input file.\n");
        return 1;
    }

    FILE* lexerFile = fopen("test_lexer.txt", "w");

    if (!lexerFile) {
        printf("Failed to create test_lexer.txt file.\n");
        fclose(inputFile);
        return 1;
    }

    yyin = inputFile;
    yyout = lexerFile;

    yyparse();

    fclose(inputFile);
    fclose(lexerFile);
    return 0;
}