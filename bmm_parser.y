%{
#include <stdio.h>

extern int yylex();
void yyerror(const char* s);
%}

%union {
    char* string;
}

%token <string> NUM STR COMMA SEMICOLON
%token <string> FUNCNAME
%token <string> LINENUM COMMENT LET PRINT IF THEN FOR TO STEP NEXT VAR DATA INPUT DIM DEF GOTO GOSUB RETURN END STOP
%left <string> PLUS MINUS MULTIPLY DIVIDE EXPONENT LPAREN RPAREN EQUAL NOTEQUAL LESS LESSEQUAL GREATER GREATEREQUAL NOT AND OR XOR

%%

PROGRAM     : LINENUM STATEMENT
            | LINENUM STATEMENT PROGRAM
            ;

STATEMENT   : COMMENT
            | LET VAR EQUAL EXPR
            | PRINT PRINTSTATEMENT
            | IF EXPR THEN NUM
            | FOR FORSTATEMENT
            | NEXT VAR
            | DATA DATASTATEMENT
            | DEF FUNCSTATEMENT
            | DIM DECLSTATEMENT
            | INPUT INPUTSTATEMENT
            | GOSUB NUM
            | GOTO NUM
            | RETURN
            | STOP
            | END
            ;

FORSTATEMENT    : VAR EQUAL EXPR TO EXPR
                | VAR EQUAL EXPR TO EXPR STEP EXPR
                ;

DATASTATEMENT   : VAL
                | VAL COMMA DATASTATEMENT
                ;

FUNCSTATEMENT   : FUNCNAME LPAREN VAR RPAREN EQUAL EXPR
                | FUNCNAME EQUAL EXPR
                ;

DECLSTATEMENT   : VAR LPAREN NUM RPAREN
                | VAR LPAREN NUM COMMA NUM RPAREN
                | VAR LPAREN NUM RPAREN COMMA DECLSTATEMENT
                | VAR LPAREN NUM COMMA NUM RPAREN COMMA DECLSTATEMENT
                ;

INPUTSTATEMENT  : VAR
                | VAR LPAREN VAR1 RPAREN
                | VAR LPAREN VAR1 COMMA VAR1 RPAREN
                | VAR COMMA INPUTSTATEMENT
                | VAR LPAREN VAR1 RPAREN COMMA INPUTSTATEMENT
                | VAR LPAREN VAR1 COMMA VAR1 RPAREN COMMA INPUTSTATEMENT
                ;

PRINTSTATEMENT  : EXPR
                | EXPR COMMA
                | EXPR SEMICOLON
                | EXPR COMMA PRINTSTATEMENT
                | EXPR SEMICOLON PRINTSTATEMENT
                ;

EXPR        : EXPR PLUS EXPR
            | EXPR MINUS EXPR
            | EXPR MULTIPLY EXPR
            | EXPR DIVIDE EXPR
            | EXPR EXPONENT EXPR
            | EXPR EQUAL EXPR
            | EXPR NOTEQUAL EXPR
            | EXPR LESS EXPR
            | EXPR LESSEQUAL EXPR
            | EXPR GREATER EXPR
            | EXPR GREATEREQUAL EXPR
            | LPAREN EXPR RPAREN
            | MINUS EXPR %prec NOT
            | NOT EXPR
            | EXPR AND EXPR
            | EXPR OR EXPR
            | EXPR XOR EXPR
            | VAR
            | VAR LPAREN VAR1 RPAREN
            | VAR LPAREN VAR1 COMMA VAR1 RPAREN
            | VAL
            | FUNCNAME LPAREN EXPR RPAREN
            ;

VAR1        : VAR
            | NUM
            ;

VAL             : NUM
                | STR
                ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}