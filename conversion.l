%option noyywrap
%{
#include <stdio.h>
#include <string.h>
%}

PLUS     "+"
MINUS    "-"
MULTIPLY "*"
DIVIDE   "/"
NEGATE   "!"
GREATER  ">"
LESS     "<"
EQUAL    "="
IDENTIFIER [a-zA-Z][a-zA-Z0-9]*
NUMBER   [0-9]+
WHITESPACE [ \t\n]+

%%

{PLUS}     { printf("|| "); }
{MINUS}    { printf(" && ! "); }
{MULTIPLY} { printf("&& "); }
{DIVIDE}   { printf(" || !"); }
{NEGATE}   { printf("! "); }
{GREATER}  { printf("> "); }
{LESS}     { printf("< "); }
{EQUAL}    { printf("== "); }
{IDENTIFIER} { printf("%s ", yytext); }
{NUMBER}    { printf("%s ", yytext); }
{WHITESPACE}  { /* ignore */ }
.          { printf("%s ", yytext); }

%%

int main() {
    yylex();
    return 0;
}
