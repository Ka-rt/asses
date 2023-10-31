%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
extern int yylex();
%}
%token ID NUM WHILE LE GE EQ NE OR AND FOR
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%right UMINUS
%left '!'
%%
prog    : S prog
                |
S        : ST1 {printf("Input accepted.\n");};
         ST1    :    WHILE'(' E2 ')' '{' ST '}'
          | FOR '(' E ';' E2 ';' E ')' '{' ST '}'
ST      :     ST ST
                  | E';'
          ;
E       : ID'='E
                  | E'+'E
          | E'-'E
          | E'*'E
          | E'/'E
          | E'<'E
          | E'>'E
          | E LE E
          | E GE E
          | E EQ E
          | E NE E
          | E OR E
          | E AND E
          | ID
          | NUM
          ;
E2     : E'<'E
                 | E'>'E
          | E LE E
          | E GE E
          | E EQ E
          | E NE E
          | E OR E
          | E AND E
          | ID
          | NUM
          ;

%%

void yyerror(char *s){
        printf("%s\n",s);
}

int main(){
   yyin = fopen("sample.c","r");
   yyparse();
}
