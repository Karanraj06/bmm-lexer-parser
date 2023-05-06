%{
#include <stdio.h>
#include <string.h>
int yylex(void);
int yyparse(void);
void yyerror(char *s);
%}
%token LINENUM COMMENT LET PRINT IF THEN ELSE FOR STEP NEXT VAR DATA INPUT DIM DEF GOTO GOSUB RETURN END STOP EXPR BOOLEXPR
%left PLUS MINUS MULT DIV EXPONENT LPAREN RPAREN EQUAL NOTEQUAL LESS LESSEQUAL GREATER GREATEREQUAL NOT AND OR XOR

%%
PROGRAM : LINE PROGRAM
        | LINE
        ;
LINE    : LINENUM STATEMENT
        | LINENUM COMMENT
        ;
STATEMENT : LET VAR EQUAL EXPR
          | PRINT EXPR
          | IF BOOLEXPR THEN 
          | ELSE
          | FOR
          | STEP
          | NEXT
          | VAR
          | DATA
          | INPUT
          | DIM
          | DEF
          | GOTO
          | GOSUB
          | RETURN  
          | END
          | STOP
          ;
%%