%{
#include <stdio.h>
#include <string.h>
#include "BMM_Parser.tab.h"
int yylineno = 1;
void yyerror(char* s);
FILE* lexer;
%}

%%
^[1-9][0-9]*0      {fprintf(lexer, "Line Number: %s\n", yytext);}   // Line Number
REM([ ].*)?             {fprintf(lexer, "Statement Type: REM\nComment: ");
                    for(int i = 4; i < strlen(yytext); i++)
                        fprintf(lexer, "%c", yytext[i]);
                    fprintf(lexer, "\n");}
LET                {fprintf(lexer, "Statement Type: LET\n"); return LET;}       // Statement Types
PRINT              {fprintf(lexer, "Statement Type: PRINT\n"); return PRINT;}
IF                 {fprintf(lexer, "Statement Type: IF\n"); return IF;}
THEN               {fprintf(lexer, "Statement Type: THEN\n"); return THEN;}
FOR                {fprintf(lexer, "Statement Type: FOR\n"); return FOR;}
TO                 {fprintf(lexer, "Statement Type: TO\n"); return TO;}
STEP               {fprintf(lexer, "Statement Type: STEP\n"); return STEP;}
NEXT               {fprintf(lexer, "Statement Type: NEXT\n"); return NEXT;}
INPUT              {fprintf(lexer, "Statement Type: INPUT\n"); return INPUT;}
RETURN             {fprintf(lexer, "Statement Type: RETURN\n"); return RETURN;}
DIM                {fprintf(lexer, "Statement Type: DIM\n"); return DIM;}
DEF                {fprintf(lexer, "Statement Type: DEF\n"); return DEF;}
DATA               {fprintf(lexer, "Statement Type: DATA\n"); return DATA;}
GOTO               {fprintf(lexer, "Statement Type: GOTO\n"); return GOTO;}
GOSUB              {fprintf(lexer, "Statement Type: GOSUB\n"); return GOSUB;}
END                {fprintf(lexer, "Statement Type: END\n"); return END;}
STOP               {fprintf(lexer, "Statement Type: STOP\n"); return STOP;}

\(                 {fprintf(lexer, "Operator: Left Paranthesis '('\n"); return LPAREN;} // Operators
\)                 {fprintf(lexer, "Operator: Right Paranthesis ')'\n"); return RPAREN;}
","                {fprintf(lexer, "Operator: Comma ','\n"); return COMMA;}
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

\".*\"                         {fprintf(lexer, "String Literal: %s\n", yytext); return STR;} // String Literal      // Values
(([1-9][0-9]+)|([0-9]))([.][0-9]+)?           {fprintf(lexer, "Numeric Literal: %s\n", yytext); return NUM;} // Numeric Literal

[ \t]                          /* Ignoring Newline, Tab and Whitespace*/
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