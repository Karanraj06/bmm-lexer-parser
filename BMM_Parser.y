%{
#include <stdio.h>
#include <string.h>
int yylex(void);
int yyparse(void);
void yyerror(char *s);
%}

%token LineNum Comment Let Print If Then Else For Step Next Var Data Input Dim Def Goto Gosub Return End Stop
%left plus minus mult div exponent lparen rparen equal not_equal less less_equal greater greater_equal not and or xor

%%
Program : Line Program
        | Line
        ;
Line    : LineNum Statement
        | LineNum Comment
        ;
Statement : Let Var equal Expr
          | Print Expr
          | If boolExpr Then 
          | Else
          | For
          | Step
          | Next
          | Var
          | Data
          | Input
          | Dim
          | Def
          | Goto
          | Gosub
          | Return  
          | End
          | Stop
          ;
%%