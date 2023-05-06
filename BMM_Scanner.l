%{
#include <stdio.h>
#include <string.h>

#include "BMM_Parser.tab.h"

void yyerror(char* s);
FILE* lexer;
%}

%%
^[1-9][0-9]*0      {fprintf(lexer, "Line Number: %s", yytext);} // Line Number

REM[ ][*|A-Z]*     {fprintf(lexer, "Statement Type: REM\nComment: %s\n", yytext);}      // Statement Types
LET                {fprintf(lexer, "Statement Type: LET\n");}
PRINT              {fprintf(lexer, "Statement Type: PRINT\n");}
IF                 {fprintf(lexer, "Statement Type: IF\n");}
THEN               {fprintf(lexer, "Statement Type: THEN\n");}
INPUT              {fprintf(lexer, "Statement Type: INPUT\n");}
RETURN             {fprintf(lexer, "Statement Type: RETURN\n");}
FOR                {fprintf(lexer, "Statement Type: FOR\n");}
DIM                {fprintf(lexer, "Statement Type: DIM\n");}
DEF                {fprintf(lexer, "Statement Type: DEF\n");}
DATA               {fprintf(lexer, "Statement Type: DATA\n");}
END                {fprintf(lexer, "Statement Type: END\n");}
STOP               {fprintf(lexer, "Statement Type: STOP\n");}

\(                  {fprintf(lexer, "Operator: Left Paranthesis \'(\'\n");}
\)                  {fprintf(lexer, "Operator: Right Paranthesis \')\'\n");}
"^"                {fprintf(lexer, "Operator: Exponentiation \')\'\n");}
"-"                {fprintf(lexer, "Operator: Minus \'-\'\n");}
"+"                {fprintf(lexer, "Operator: Minus \'+\'\n");}
"*"                {fprintf(lexer, "Operator: Multiplication \'*\'\n");}
"/"                {fprintf(lexer, "Operator: Division \'/\'\n");}
"="                {fprintf(lexer, "Operator: Equal \'=\'\n");}
"<>"               {fprintf(lexer, "Operator: Inequality \'<>\'\n");}
"<"                {fprintf(lexer, "Operator: Less Than  \'<\'\n");}
">"                {fprintf(lexer, "Operator: Greater Than \'>\'\n");}
"<="               {fprintf(lexer, "Operator: Less than equal to \'<=\'\n");}
">="               {fprintf(lexer, "Operator: Greater than equal to \'>=\'\n");}


[A-Z][0-9]?[%]?     {fprintf(lexer, "Variable ID: %s", yytext);} // Integer             // Variable Name
[A-Z][0-9]?[!]      {fprintf(lexer, "Variable ID: %s", yytext);} // Single-Precision 
[A-Z][0-9]?[#]      {fprintf(lexer, "Variable ID: %s", yytext);} // Double-Precision
[A-Z][0-9]?[$]      {fprintf(lexer, "Variable ID: %s", yytext);} // String

\"[.]*\"                {fprintf(lexer, "Variable ID: %s", yytext);} // String Literal
[1-9][0-9]*[.]?[0-9]*            {fprintf(lexer, "Variable ID: %s", yytext);} // Numeric Literal


\n                 {fprintf(lexer, "\n");}
.*                 {fprintf(lexer, "Unidentified token");}

%%

int yywrap(void) {
    return 1;
}

void yyerror(char* s) {
    printf("Error: %s\n", s);
}