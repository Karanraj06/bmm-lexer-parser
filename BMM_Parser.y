%{
#include <stdio.h>
#include <string.h>
int yylex(void);
int yyparse(void);
void yyerror(char *s);
FILE *yyin, *lexer, *parser;
%}
%token LINENUM COMMENT LET PRINT IF THEN ELSE FOR STEP NEXT VAR DATA INPUT DIM DEF GOTO GOSUB RETURN END STOP EXPR BOOLEXPR
%left PLUS MINUS MULT DIV EXPONENT LPAREN RPAREN EQUAL NOTEQUAL LESS LESSEQUAL GREATER GREATEREQUAL NOT AND OR XOR

%token NUM STR
%token FUNCNAME
%token LINENUM COMMENT LET PRINT IF THEN FOR TO STEP NEXT VAR DATA INPUT DIM DEF GOTO GOSUB RETURN END STOP
%left PLUS MINUS MULTIPLY DIVIDE EXPONENT LPAREN RPAREN EQUAL NOTEQUAL LESS LESSEQUAL GREATER GREATEREQUAL NOT AND OR XOR

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
          | IF BOOLEXPR THEN NUM
          | FOR VAR EQUAL EXPR TO EXPR STEP EXPR
          | NEXT VAR
          | DATASTATEMENT
          | INPUTSTATEMENT
          | DIM DECLARATIONS
          | DEF FUNCNAME '(' VAR ')' EQUAL EXPR
          | DEF FUNCNAME EQUAL EXPR
          | GOTO NUM
          | GOSUB NUM
          | RETURN  
          | END
          | STOP
          ;
EXPR            : EXPR AROPERATOR EXPR
                | LPAREN EXPR RPAREN
                | BOOLEXPR
                | VAR
                | STR
                | NUM
                ;
AROPERATOR      : PLUS
                | MINUS
                | MULTIPLY
                | DIVIDE
                | EXPONENT
                ;
BOOLEXPR        : BOOLEXPR BOOLOPERATOR BOOLEXPR
                | LPAREN BOOLEXPR RPAREN
                | NOT BOOLEXPR
                | VAR
                | NUM
                ;
BOOLOPERATOR    : EQUAL
                | NOTEQUAL
                | LESS
                | LESSEQUAL
                | GREATER
                | GREATEREQUAL
                | AND
                | OR
                | XOR
                ;
DATASTATEMENT   : DATA EXPR
                | DATASTATEMENT ',' EXPR
                ;
INPUTSTATEMENT : INPUT VAR
               | INPUTSTATEMENT ',' VAR
               ;
DECLARATIONS   : DECLARATION
               | DECLARATIONS ',' DECLARATION
               ;
DECLARATION    : VAR '(' NUM ')'
               | VAR '(' NUM ',' NUM ')' 
               ;
%%

int main(int argc, char *argv[]) {
        yyin = fopen(argv[1], "r");
        lexer = fopen("test_lexer.txt", "w");
        parser = fopen("test_parser.txt", "w");   
        yyparse();      
        fclose(yyin);
        fclose(lexer);
        fclose(parser);
        return 0;
}