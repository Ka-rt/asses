%option noyywrap
%{
#include<stdio.h>
#include<string.h>
char *cond1,*cond2,*stmt1,*stmt2,*elseblock;
%}

%x if1
%x if2
%x if3

%%

"if("   {BEGIN if1;}
<if1>[^()&]*"&" {yytext[yyleng-1]='\0';cond1=strdup(yytext);}
<if1>"&"[^()&]*"){"     {yytext[yyleng-2]='\0';yytext++;cond2=strdup(yytext);}
<if1>[^{}]*"}"  {yytext[yyleng-1]='\0';stmt1=strdup(yytext);BEGIN if2;}
<if2>"else if(".*"){"   ;
<if2>[^{}]*"}"  {yytext[yyleng-1]='\0';stmt2=strdup(yytext);BEGIN if3;}
<if3>(.|\n)*    {elseblock=strdup(yytext);
                printf("if(%s){\n\tif(%s){%s\t}\n\telse{%s\t}\n}\n%s\n",cond1,cond2,stmt1,stmt2,elseblock);
                BEGIN INITIAL;}
%%

int main(){
        yyin=fopen("ifelse.txt","r");
        yylex();
        return 0;
}
