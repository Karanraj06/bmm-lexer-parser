%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "y.tab.h"

extern char* yytext;
extern FILE* yyout;
extern int yylineno;
%}

%%
^[1-9][0-9]*0      { fprintf(yyout, "Line Number: %s\n", yytext); yylval.string = strdup(yytext); return LINENUM; }
REM([ ].*)?        { fprintf(yyout, "Statement Type: REM\nComment: "); for (int i = 4; i < strlen(yytext); i++) fprintf(yyout, "%c", yytext[i]); fprintf(yyout, "\n"); yylval.string = strdup(yytext); return COMMENT; }
LET                { fprintf(yyout, "Statement Type: LET\n"); return LET; }
PRINT              { fprintf(yyout, "Statement Type: PRINT\n"); return PRINT; }
IF                 { fprintf(yyout, "Statement Type: IF\n"); return IF; }
THEN               { fprintf(yyout, "Statement Type: THEN\n"); return THEN; }
FOR                { fprintf(yyout, "Statement Type: FOR\n"); return FOR; }
TO                 { fprintf(yyout, "Statement Type: TO\n"); return TO; }
STEP               { fprintf(yyout, "Statement Type: STEP\n"); return STEP; }
NEXT               { fprintf(yyout, "Statement Type: NEXT\n"); return NEXT; }
INPUT              { fprintf(yyout, "Statement Type: INPUT\n"); return INPUT; }
RETURN             { fprintf(yyout, "Statement Type: RETURN\n"); return RETURN; }
DIM                { fprintf(yyout, "Statement Type: DIM\n"); return DIM; }
DEF                { fprintf(yyout, "Statement Type: DEF\n"); return DEF; }
DATA               { fprintf(yyout, "Statement Type: DATA\n"); return DATA; }
GOTO               { fprintf(yyout, "Statement Type: GOTO\n"); return GOTO; }
GOSUB              { fprintf(yyout, "Statement Type: GOSUB\n"); return GOSUB; }
END                { fprintf(yyout, "Statement Type: END\n"); return END; }
STOP               { fprintf(yyout, "Statement Type: STOP\n"); return STOP; }
\".*\"               { fprintf(yyout, "String Literal: %s\n", yytext); yylval.string = strdup(yytext); return STR; }
(([1-9][0-9]+)|([0-9]))([.][0-9]+)? { fprintf(yyout, "Numeric Literal: %s\n", yytext); yylval.string = strdup(yytext); return NUM; }
FN[A-Z]            { fprintf(yyout, "Function Name: %s\n", yytext); return FUNCNAME; }
\(                 { fprintf(yyout, "Operator: Left Parenthesis '('\n"); return LPAREN; }
\)                 { fprintf(yyout, "Operator: Right Parenthesis ')'\n"); return RPAREN; }
","                { fprintf(yyout, "Operator: Comma ','\n"); return COMMA; }
";"                { fprintf(yyout, "Operator: Semicolon ';'\n"); return SEMICOLON; }
"^"                { fprintf(yyout, "Operator: Exponentiation '^'\n"); return EXPONENT; }
"-"                { fprintf(yyout, "Operator: Minus '-'\n"); return MINUS; }
"+"                { fprintf(yyout, "Operator: Plus '+'\n"); return PLUS; }
"*"                { fprintf(yyout, "Operator: Multiplication '*'\n"); return MULTIPLY; }
"/"                { fprintf(yyout, "Operator: Division '/'\n"); return DIVIDE; }
"="                { fprintf(yyout, "Operator: Equal '='\n"); return EQUAL; }
"<>"               { fprintf(yyout, "Operator: Inequality '<>'\n"); return NOTEQUAL; }
"<"                { fprintf(yyout, "Operator: Less Than '<'\n"); return LESS; }
">"                { fprintf(yyout, "Operator: Greater Than '>'\n"); return GREATER; }
"<="               { fprintf(yyout, "Operator: Less than or equal to '<='\n"); return LESSEQUAL; }
">="               { fprintf(yyout, "Operator: Greater than or equal to '>='\n"); return GREATEREQUAL; }
NOT                { fprintf(yyout, "Operator: NOT\n"); return NOT; }
AND                { fprintf(yyout, "Operator: AND\n"); return AND; }
OR                 { fprintf(yyout, "Operator: OR\n"); return OR; }
XOR                { fprintf(yyout, "Operator: XOR\n"); return XOR; }
[A-Z][0-9]?[%]?    { fprintf(yyout, "Variable ID: %s\n", yytext); return VAR; }
[A-Z][0-9]?[!]     { fprintf(yyout, "Variable ID: %s\n", yytext); return VAR; }
[A-Z][0-9]?[#]     { fprintf(yyout, "Variable ID: %s\n", yytext); return VAR; }
[A-Z][0-9]?[$]     { fprintf(yyout, "Variable ID: %s\n", yytext); return VAR; }
[ \t]              { /* Ignoring Newline, Tab and Whitespace */ }
\n                 { fprintf(yyout, "\n"); yylineno++; }
.                  { /* Ignoring Invalid Character */ }
%%

int yywrap() {
    return 1;
}