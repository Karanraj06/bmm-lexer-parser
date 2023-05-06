%{
#include <stdio.h>
#include <string.h>
int yylex(void);
int yyparse(void);
void yyerror(char *s);
FILE *yyin, *lexer;
%}

%token NUM STR
%token EXPR BOOLEXPR
%token LINENUM COMMENT LET PRINT IF THEN FOR TO STEP NEXT VAR DATA INPUT DIM DEF GOTO GOSUB RETURN END STOP
%left PLUS MINUS MULT DIV EXPONENT LPAREN RPAREN EQUAL NOT_EQUAL LESS LESS_EQUAL GREATER GREATER_EQUAL NOT AND OR XOR

%%
PROGRAM : LINE PROGRAM
        | LINE
        ;
LINE    : LINENUM STATEMENT
        | LINENUM COMMENT
        ;
STATEMENT : LET VAR EQUAL EXPR
          | PRINT EXPR
          | IF BOOLEXPR THEN NUM
          | FOR VAR EQUAL EXPR TO EXPR STEP EXPR
          | NEXT VAR
          | DATASTATEMENT
          | INPUTSTATEMENT
          | DIM
          | DEF
          | GOTO
          | GOSUB
          | RETURN  
          | END
          | STOP
          ;
DATASTATEMENT : DATA EXPR
              | DATASTATEMENT ',' EXPR
              ;
INPUTSTATEMENT : INPUT VAR
               | INPUTSTATEMENT ',' VAR
               ;
%%

int main(int argc, char *argv[]) {
        yyin = fopen(argv[1], "r");
        lexer = fopen("test_lexer.txt", "w");
        parser = fopen("Parser.txt", "w");   
        yyparse();      
        fclose(yyin);
        fclose(lexer);
        fclose(parser);
        return 0;
}