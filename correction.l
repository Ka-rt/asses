%option noyywrap
%{
#include<stdio.h>
#include<string.h>
%}
%x string
%x multicomment
%x singlecomment

%%

["] {ECHO;BEGIN string;}
<string>["] {ECHO;BEGIN INITIAL;}
"//" {ECHO;BEGIN singlecomment;}
<singlecomment>"\n" {ECHO;BEGIN INITIAL;}
"/*" {ECHO;BEGIN multicomment;}
<multicomment>"*/" {ECHO;BEGIN INITIAL;}
[\n\t(]?("unt"|"INT"|"ont"|"imt"|"ijt"|"it"|"nit"|"iny")" " {printf("int ");}
[\n\t(]?("shirt"|"shot"|"sgort"|"dhort"|"ahort"|"shotr")" " {printf("short ");}
[\n\t(]?("flot"|"flat"|"floot"|"flaot"|"flota")" " {printf("float ");}
[\n\t(]?("chsr"|"chra"|"chat"|"chart"|"xhar"|"chra")" " {printf("char ");}
. printf("%s",yytext);


%%

int main(){
        yylex();
        return 0;
}
