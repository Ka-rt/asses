
%{
        #include<stdio.h>
%}
%token ID NUMBER SWITCH CLN DFT CASE BRK GT LT GE LE E NE OP CP OB CB SC AND OR NOT INCR DECR ADD SUB MUL DIV EQ
%%
crt:start  { printf("Valid "); }
start:    SWITCH OP  ID CP body ;
body:   OB stmts CB |
        stmt SC ;
stmts: CASE NUMBER CLN OB stmt SC BRK SC CB stmts
     |stmts

   | DFT CLN stmt SC
|  
     ;
init:   stmt |
        ;
increment:      stmt |
                ID INCR |
                ID DECR |
                ;
stmt:   ID EQ expr | increment;
expr:   expr ADD term |
        expr SUB term |
        term ;
term:   term MUL factor |
        term DIV factor |
        factor;
factor: ID |
        NUMBER ;
relop: GT | LT | GE | LE | E | NE;
%%
void yyerror(const char *str) {
        printf("Error ");
}
int main() {
        yyparse();
        return 0;
}
