%%{
#include <stdio.h>
#include <string.h>

int yylex(void);
void yyerror(char* s);

FILE* lexer;
FILE* parser;
%}

%token NUM STR
%token FUNCNAME
%token LINENUM COMMENT LET PRINT IF THEN FOR TO STEP NEXT VAR DATA INPUT DIM DEF GOTO GOSUB RETURN END STOP
%left PLUS MINUS MULTIPLY DIVIDE EXPONENT LPAREN RPAREN EQUAL NOTEQUAL LESS LESSEQUAL GREATER GREATEREQUAL NOT AND OR XOR

%%
PROGRAM : LINE PROGRAM
        | LINE
        ;
LINE    : LINENUM STATEMENT { fprintf(parser, "Line Number: %s\n", $1); }
        | LINENUM COMMENT { fprintf(parser, "Line Number: %s\nComment: %s\n", $1, $2); }
        ;
STATEMENT : LET VAR EQUAL EXPR { fprintf(parser, "Statement: LET %s = %s\n", $2, $4); }
          | PRINT EXPR { fprintf(parser, "Statement: PRINT %s\n", $2); }
          | IF BOOLEXPR THEN { fprintf(parser, "Statement: IF %s THEN\n", $2); }
          | FOR { fprintf(parser, "Statement: FOR\n"); }
          | STEP { fprintf(parser, "Statement: STEP\n"); }
          | NEXT { fprintf(parser, "Statement: NEXT\n"); }
          | VAR { fprintf(parser, "Statement: VAR %s\n", $1); }
          | DATA { fprintf(parser, "Statement: DATA\n"); }
          | INPUT { fprintf(parser, "Statement: INPUT\n"); }
          | DIM { fprintf(parser, "Statement: DIM\n"); }
          | DEF FUNCNAME '(' VAR ')' EQUAL EXPR { fprintf(parser, "Statement: DEF %s(%s) = %s\n", $2, $4, $7); }
          | DEF FUNCNAME EQUAL EXPR { fprintf(parser, "Statement: DEF %s = %s\n", $2, $4); }
          | GOTO { fprintf(parser, "Statement: GOTO\n"); }
          | GOSUB { fprintf(parser, "Statement: GOSUB\n"); }
          | IF BOOLEXPR THEN NUM { fprintf(parser, "Statement: IF %s THEN %s\n", $2, $4); }
          | FOR VAR EQUAL EXPR TO EXPR STEP EXPR { fprintf(parser, "Statement: FOR %s = %s TO %s STEP %s\n", $2, $4, $6, $8); }
          | NEXT VAR { fprintf(parser, "Statement: NEXT %s\n", $2); }
          | DATASTATEMENT { fprintf(parser, "Statement: DATA %s\n", $1); }
          | INPUTSTATEMENT { fprintf(parser, "Statement: INPUT %s\n", $1); }
          | DIM DECLARATIONS { fprintf(parser, "Statement: DIM %s\n", $1); }
          | GOTO NUM { fprintf(parser, "Statement: GOTO %s\n", $2); }
          | GOSUB NUM { fprintf(parser, "Statement: GOSUB %s\n", $2); }
          | RETURN { fprintf(parser, "Statement: RETURN\n"); }
          | END { fprintf(parser, "Statement: END\n"); }
          | STOP { fprintf(parser, "Statement: STOP\n"); }
          ;
EXPR    : EXPR AROPERATOR EXPR {
              switch ($2) {
                  case PLUS:
                      fprintf(parser, "Expression: %s + %s\n", $1, $3);
                      break;
                  case MINUS:
                      fprintf(parser, "Expression: %s - %s\n", $1, $3);
                      break;
                  case MULTIPLY:
                      fprintf(parser, "Expression: %s * %s\n", $1, $3);
                      break;
                  case DIVIDE:
                      fprintf(parser, "Expression: %s / %s\n", $1, $3);
                      break;
                  case EXPONENT:
                      fprintf(parser, "Expression: %s ^ %s\n", $1, $3);
                      break;
              }
          }
        | LPAREN EXPR RPAREN { fprintf(parser, "Expression: (%s)\n", $2); }
        | BOOLEXPR { fprintf(parser, "Expression: %s\n", $1); }
        | VAR { fprintf(parser, "Expression: VAR %s\n", $1); }
        | STR { fprintf(parser, "Expression: STR %s\n", $1); }
        | NUM { fprintf(parser, "Expression: NUM %s\n", $1); }
        ;

AROPERATOR      : PLUS { fprintf(parser, "AR Operator: +\n"); }
                | MINUS { fprintf(parser, "AR Operator: -\n"); }
                | MULTIPLY { fprintf(parser, "AR Operator: *\n"); }
                | DIVIDE { fprintf(parser, "AR Operator: /\n"); }
                | EXPONENT { fprintf(parser, "AR Operator: ^\n"); }
                ;

BOOLEXPR        : BOOLEXPR BOOLOPERATOR BOOLEXPR {
                      switch ($2) {
                          case EQUAL:
                              fprintf(parser, "Boolean Expression: %s == %s\n", $1, $3);
                              break;
                          case NOTEQUAL:
                              fprintf(parser, "Boolean Expression: %s != %s\n", $1, $3);
                              break;
                          case LESS:
                              fprintf(parser, "Boolean Expression: %s < %s\n", $1, $3);
                              break;
                          case LESSEQUAL:
                              fprintf(parser, "Boolean Expression: %s <= %s\n", $1, $3);
                              break;
                          case GREATER:
                              fprintf(parser, "Boolean Expression: %s > %s\n", $1, $3);
                              break;
                          case GREATEREQUAL:
                              fprintf(parser, "Boolean Expression: %s >= %s\n", $1, $3);
                              break;
                          case AND:
                              fprintf(parser, "Boolean Expression: %s && %s\n", $1, $3);
                              break;
                          case OR:
                              fprintf(parser, "Boolean Expression: %s || %s\n", $1, $3);
                              break;
                          case XOR:
                              fprintf(parser, "Boolean Expression: %s XOR %s\n", $1, $3);
                              break;
                      }
                  }
                | LPAREN BOOLEXPR RPAREN { fprintf(parser, "Boolean Expression: (%s)\n", $2); }
                | NOT BOOLEXPR { fprintf(parser, "Boolean Expression: NOT %s\n", $2); }
                | VAR { fprintf(parser, "Boolean Expression: VAR %s\n", $1); }
                | NUM { fprintf(parser, "Boolean Expression: NUM %s\n", $1); }
                ;

BOOLOPERATOR    : EQUAL { fprintf(parser, "Boolean Operator: ==\n"); }
                | NOTEQUAL { fprintf(parser, "Boolean Operator: !=\n"); }
                | LESS { fprintf(parser, "Boolean Operator: <\n"); }
                | LESSEQUAL { fprintf(parser, "Boolean Operator: <=\n"); }
                | GREATER { fprintf(parser, "Boolean Operator: >\n"); }
                | GREATEREQUAL { fprintf(parser, "Boolean Operator: >=\n"); }
                | AND { fprintf(parser, "Boolean Operator: &&\n"); }
                | OR { fprintf(parser, "Boolean Operator: ||\n"); }
                | XOR { fprintf(parser, "Boolean Operator: XOR\n"); }
                ;
DATASTATEMENT   : DATA EXPR {
                      fprintf(parser, "Data Statement: DATA %s\n", $2);
                  }
                | DATASTATEMENT ',' EXPR {
                      fprintf(parser, "Data Statement: %s, %s\n", $1, $3);
                  }
                ;

INPUTSTATEMENT : INPUT VAR {
                     fprintf(parser, "Input Statement: INPUT %s\n", $2);
                 }
               | INPUTSTATEMENT ',' VAR {
                     fprintf(parser, "Input Statement: %s, %s\n", $1, $3);
                 }
               ;

DECLARATIONS   : DECLARATION {
                     fprintf(parser, "Declaration: %s\n", $1);
                 }
               | DECLARATIONS ',' DECLARATION {
                     fprintf(parser, "Declaration: %s, %s\n", $1, $3);
                 }
               ;

DECLARATION    : VAR '(' NUM ')' {
                     fprintf(parser, "Declaration: %s(%s)\n", $1, $3);
                 }
               | VAR '(' NUM ',' NUM ')' {
                     fprintf(parser, "Declaration: %s(%s, %s)\n", $1, $3, $5);
                 }
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