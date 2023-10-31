%option noyywrap
%{
#include <stdio.h>
#include<string.h>
        struct SymbolEntry {
                char name[64];
                char type[16];
                int line;
        };
        struct SymbolEntry table[100]={"" ,"",0};
        int count =0,n=1;
        char name[20];
        void addSymbol(char* name, char* type,int line) {
                strcpy(table[count].name,name);
                strcpy(table[count].type,type);
                table[count].line = line;
                count++;
        }
        char str[16];
        void display(){
                printf("\n-----Symbol table------\n");
                printf("Name\t|Type\t\t|lineno\t\n");
                for(int i=0;i<count;i++){
                        printf("%s\t|%s\t\t|%d\n",table[i].name,table[i].type,table[i].line);
                }
                printf("----------------------------------------\n");
        }
%}
KEYWORD    int|void|char|float|double|long
STRUCT     typedef struct|struct
%x character
%x content
%x integer
%x floatv
%x header
%x structure
%x function
%x returnval
%x next
%x check
%%
#include { BEGIN header;}
<header>[a-zA-Z]+".h" { addSymbol(yytext,"header",n);BEGIN INITIAL;}
struct[ ]+ { BEGIN structure; }
<structure>[a-zA-Z]+[ ]* {addSymbol(yytext,"struct type",n);BEGIN next;}
<next>"}"[a-zA-Z0-9]*";" {
        for(int i=1,j=0;i<yyleng-1;i++,j++){
                name[j] = yytext[i];}
        addSymbol(name,"struct variable",n);BEGIN INITIAL;}
int[ ]+ { BEGIN integer; }
<integer>[a-zA-Z]+[ ]* {
        if(strcmp(yytext,"int")==0|strcmp(yytext,"for")==0|strcmp(yytext,"if")==0|strcmp(yytext,"while")==0){
                addSymbol(yytext,"error",n);BEGIN INITIAL;}
        else{
        addSymbol(yytext,"int",n);BEGIN INITIAL;}
        }
float[ ]+ { BEGIN floatv; }
<floatv>[a-zA-Z]+[ ]* { addSymbol(yytext,"float",n); BEGIN INITIAL;}
char[ ]+ { BEGIN character; }
<character>[a-zA-Z][ ]* { addSymbol(yytext,"char",n);BEGIN INITIAL;}

{KEYWORD}[ ]+ { strcpy(str,yytext);BEGIN function;}
<function>[a-zA-Z]+"("")" { addSymbol(yytext,str,n);BEGIN INITIAL;}
{KEYWORD}[ ]*[a-zA-Z]+"("[a-zA-Z]+")" { addSymbol(yytext,"parameter",n);}

printf|scanf { addSymbol(yytext,"input/output",n); BEGIN content;}
<content>[ ]*[a-zA-Z\""%.,!]*[ ]*[a-zA-Z\"".,%!]* { addSymbol(yytext,"I/O content",n);BEGIN INITIAL;}
int|float|char[ ]+[a-zA-Z]+"[]" { addSymbol(yytext,"array",n);BEGIN INITIAL;}

return { addSymbol(yytext,"complete",n);BEGIN returnval;}
'[a-zA-Z]' { addSymbol(yytext,"character",n);}

<returnval>[ ]+[a-zA-Z0-9] { addSymbol(yytext,"return value",n); BEGIN INITIAL;}
[a-zA-Z][a-zA-Z0-9]* { addSymbol(yytext, "identifier",n); }
[0-9]+ { addSymbol(yytext, "int value",n); }
[0-9]+\.[0-9]+ { addSymbol(yytext, "floatvalue",n); }
[ \t]           /* Ignore whitespace and newlines */
\n { n++;}

.       {;}
<next>. {;}

%%

int main() {
        //yylex();<content>[ ]*[a-zA-Z]* { addSymbol(yytext,"I/O content",lineno);BEGIN INITIAL;}
        yyin = fopen("sample.c","r");
        yylex();
        display();
        fclose(yyin);
        return 0;
}
