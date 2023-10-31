%option noyywrap

%{
#include <stdio.h>
char ini[20], cond[20], inc[20], stmt[100];
%}

op "++"|"--"
rop "<"|">"|"<="|">="|"=="|"!="|"&&"|"||"
id [a-zA-Z][a-zA-Z0-9]*
no [0-9]+
pp [\n\t" "]

%%

for\(({id}[ \t\n]{id}=({no}|{id}))*?;({id}{rop}({id}|{no})(rop)*|{id})*;.*\)\{(.|\n)*\} {
    int j, k, i = 0;
    while (yytext[i] != '(') i++;
    j = ++i;
    k = 0;

    while (yytext[j] != ';') {
        ini[k] = yytext[j];
        k++;
        j++;
    }
    j++;
    k = 0;

    while (yytext[j] != ';') {
        cond[k] = yytext[j];
        k++;
        j++;
    }
    j++;
    k = 0;

    while (yytext[j] != ')') {
        inc[k] = yytext[j];
        k++;
        j++;
    }
    i = 0;

    while (yytext[i] != '{') i++;
    ++i;
    k = 0;

    while (yytext[i] != '}') {
        stmt[k] = yytext[i];
        k++;
        i++;
    }
    i = 0;
    while (yytext[i] != '{') i++;

    ++i;
    k = 0;

    while (yytext[i] != '}') {
        stmt[k] = yytext[i];
        k++;
        i++;
    }
    printf("%s;", ini);
    printf("\n");
    printf("while(%s){\n", cond);
    printf("%s\n", stmt);
    printf("\t%s;\n}", inc);
}

%%

int main() {

        yyin = fopen("loop.c","r");
        yylex();
        return 0;
}
