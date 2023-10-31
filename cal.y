%{

#include<stdio.h>

int flag=0;

%}

%token NUMBER

%left '+' '-'

%left '*' '/' '%'

%left '(' ')'

%%

ArithmeticExpression: E{

printf("\nResult=%d\n", $$);

return 0;

};

E:E'+'E {$$=$1+$3;}

|E'-'E {$$=$1-$3;}

|E'*'E {$$=$1*$3;}

|E'/'E {$$=$1/$3;}

|E'%'E {$$=$1%$3;}

|'('E')' {$$=$2;}

| NUMBER {$$=$1;}

;

%%

void main()
{

printf("\n Addition,Subtraction, Multiplication, Division,Modulus and Round brackets:\n");

yyparse();

if(flag==0)

printf("Entered arithmetic expression is Valid\n\n");

}

void yyerror()

{

printf("Entered arithmetic expression is Invalid\n\n");

flag=1;

}
