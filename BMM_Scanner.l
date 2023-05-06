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
ELSE               {fprintf(lexer, "Statement Type: ELSE\n");}
FOR                {fprintf(lexer, "Statement Type: FOR\n");}
STEP               {fprintf(lexer, "Statement Type: STEP\n");}
NEXT               {fprintf(lexer, "Statement Type: NEXT\n");}
INPUT              {fprintf(lexer, "Statement Type: INPUT\n");}
RETURN             {fprintf(lexer, "Statement Type: RETURN\n");}
DIM                {fprintf(lexer, "Statement Type: DIM\n");}
DEF                {fprintf(lexer, "Statement Type: DEF\n");}
DATA               {fprintf(lexer, "Statement Type: DATA\n");}
GOTO               {fprintf(lexer, "Statement Type: GOTO\n");}
GOSUB              {fprintf(lexer, "Statement Type: GOSUB\n");}
END                {fprintf(lexer, "Statement Type: END\n");}
STOP               {fprintf(lexer, "Statement Type: STOP\n");}
REM[ ][ |*|A-Z]*   {fprintf(lexer, "Statement Type: REM\nComment: ");
                    for(int i = 4; i < strlen(yytext); i++)
                        fprintf(lexer, "%c", yytext[i]);
                    fprintf(lexer, "\n");}      // Statement Types
\(                 {fprintf(lexer, "Operator: Left Paranthesis '('\n"); return LPAREN;}
\)                 {fprintf(lexer, "Operator: Right Paranthesis ')'\n"); return RPAREN;}
"^"                {fprintf(lexer, "Operator: Exponentiation '^'\n"); return EXPONENT;}
"-"                {fprintf(lexer, "Operator: Minus '-'\n"); return MINUS;}
"+"                {fprintf(lexer, "Operator: Plus '+'\n"); return PLUS;}
"*"                {fprintf(lexer, "Operator: Multiplication '*'\n"); return MULTIPLY;}
"/"                {fprintf(lexer, "Operator: Division '/'\n"); return DIVIDE;}
"="                {fprintf(lexer, "Operator: Equal '='\n"); return EQUAL;}
"<>"               {fprintf(lexer, "Operator: Inequality '<>'\n"); return NOTEQUAL;}
"<"                {fprintf(lexer, "Operator: Less Than  '<'\n"); return LESS;}
">"                {fprintf(lexer, "Operator: Greater Than '>'\n"); return GREATER;}
"<="               {fprintf(lexer, "Operator: Less than equal to '<='\n"); return LESSEQUAL;}
">="               {fprintf(lexer, "Operator: Greater than equal to '>='\n"); return GREATEREQUAL;}
NOT                {fprintf(lexer, "Operator: NOT\n"); return NOT;}
AND                {fprintf(lexer, "Operator: AND\n"); return AND;}
OR                 {fprintf(lexer, "Operator: OR\n"); return OR;}
XOR                {fprintf(lexer, "Operator: XOR\n"); return XOR;}

[A-Z][0-9]?[%]?     {fprintf(lexer, "Variable ID: %s\n", yytext); return VAR;} // Integer             // Variable Names/IDs
[A-Z][0-9]?[!]      {fprintf(lexer, "Variable ID: %s\n", yytext); return VAR;} // Single-Precision 
[A-Z][0-9]?[#]      {fprintf(lexer, "Variable ID: %s\n", yytext); return VAR;} // Double-Precision
[A-Z][0-9]?[$]      {fprintf(lexer, "Variable ID: %s\n", yytext); return VAR;} // String

\"[.]*\"                         {fprintf(lexer, "String Literal: %s\n", yytext); return STR;} // String Literal      // Values
[1-9][0-9]*[.]?[0-9]*            {fprintf(lexer, "Numeric Literal: %s\n", yytext); return NUM;} // Numeric Literal

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