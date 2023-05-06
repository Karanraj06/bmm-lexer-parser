%{
#include <stdio.h>
#include <string.h>

#include "BMM_Parser.tab.h"
int yylineno = 1;
void yyerror(char* s);
FILE* lexer;
%}

%%
^[1-9][0-9]*0      {fprintf(lexer, "Line Number: %s", yytext);} // Line Number

REM[ ][ |*|A-Z]*   {fprintf(lexer, "Statement Type: REM\nComment: ");
                    for(int i = 4; i < strlen(yytext); i++)
                        fprintf(lexer, "%c", yytext[i]);
                    fprintf(lexer, "\n");}      // Statement Types
LET                {fprintf(lexer, "Statement Type: LET\n");}
PRINT              {fprintf(lexer, "Statement Type: PRINT\n");}
IF                 {fprintf(lexer, "Statement Type: IF\n");}
THEN               {fprintf(lexer, "Statement Type: THEN\n");}
FOR                {fprintf(lexer, "Statement Type: FOR\n");}
TO                 {fprintf(lexer, "Statement Type: TO\n");}
STEP               {fprintf(lexer, "Statement Type: STEP\n");}
NEXT               {fprintf(lexer, "Statement Type: NEXT\n");}
INPUT              {fprintf(lexer, "Statement Type: INPUT\n");}
RETURN             {fprintf(lexer, "Statement Type: RETURN\n");}
DIM                {fprintf(lexer, "Statement Type: DIM\n");}
DEF                {fprintf(lexer, "Statement Type: DEF\n");}
DATA               {fprintf(lexer, "Statement Type: DATA\n");}
GOTO               {fprintf(lexer, "Statement Type: GOTO\n");}
GOSUB              {fprintf(lexer, "Statement Type: GOSUB\n");}
RETURN             {fprintf(lexer, "Statement Type: RETURN\n");}
END                {fprintf(lexer, "Statement Type: END\n");}
STOP               {fprintf(lexer, "Statement Type: STOP\n");}

\(                 {fprintf(lexer, "Operator: Left Paranthesis '('\n");}
\)                 {fprintf(lexer, "Operator: Right Paranthesis ')'\n");}
"^"                {fprintf(lexer, "Operator: Exponentiation '^'\n");}
"-"                {fprintf(lexer, "Operator: Minus '-'\n");}
"+"                {fprintf(lexer, "Operator: Plus '+'\n");}
"*"                {fprintf(lexer, "Operator: Multiplication '*'\n");}
"/"                {fprintf(lexer, "Operator: Division '/'\n");}
"="                {fprintf(lexer, "Operator: Equal '='\n");}
"<>"               {fprintf(lexer, "Operator: Inequality '<>'\n");}
"<"                {fprintf(lexer, "Operator: Less Than  '<'\n");}
">"                {fprintf(lexer, "Operator: Greater Than '>'\n");}
"<="               {fprintf(lexer, "Operator: Less than equal to '<='\n");}
">="               {fprintf(lexer, "Operator: Greater than equal to '>='\n");}
NOT                {fprintf(lexer, "Operator: NOT\n");}
AND                {fprintf(lexer, "Operator: AND\n");}
OR                 {fprintf(lexer, "Operator: OR\n");}
XOR                {fprintf(lexer, "Operator: XOR\n");}

[A-Z][0-9]?[%]?     {fprintf(lexer, "Variable ID: %s\n", yytext);} // Integer             // Variable Names/IDs
[A-Z][0-9]?[!]      {fprintf(lexer, "Variable ID: %s\n", yytext);} // Single-Precision 
[A-Z][0-9]?[#]      {fprintf(lexer, "Variable ID: %s\n", yytext);} // Double-Precision
[A-Z][0-9]?[$]      {fprintf(lexer, "Variable ID: %s\n", yytext);} // String

\"[.]*\"                         {fprintf(lexer, "String Literal: %s\n", yytext);} // String Literal      // Values
[1-9][0-9]*[.]?[0-9]*            {fprintf(lexer, "Numeric Literal: %s\n", yytext);} // Numeric Literal

[ \t]                             /* Ignoring Newline, Tab and Whitespace*/
\n                                {fprintf(lexer, "\n"); yylineno++;}
.                                 {
                                    fprintf(lexer,"Line number %d: Lexical error, there is an undefined token in input: %s\n", yylineno, yytext);
                                  }

%%

int yywrap(void) {
    return 1;
}

void yyerror(char* s) {
    printf("Error: %s\n", s);
}