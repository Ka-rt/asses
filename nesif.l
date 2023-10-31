%option noyywrap

%{
        #include <stdio.h>
        #include <stdlib.h>
        #include <string.h>
        #define nop printf("")

        char *if1cond, *if2cond, *if3cond;

%}

if "if"
else "else"
%x IF1COND
%x IF2
%x IF2COND
%x IF3
%x IF3COND
%x IFBODY
%x ELSE3
%x ELSE3BODY
%x ELSE2
%x ELSE2BODY
%x ELSE1
%x ELSE1BODY

%%
<INITIAL>{if}"("    {printf("%s", yytext);
                                     BEGIN IF1COND;}
<IF1COND>[^")"]*     {printf("%s", yytext);
                                          if1cond = strdup(yytext);
                                     input();
                                     input();
                                     BEGIN IF2;}
<IF2>[\n\t]*{if}"("  {BEGIN IF2COND;}
<IF2COND>[^")"]*     {printf(" && %s", yytext);
                                          if2cond = strdup(yytext);
                                          input();
                                          input();
                                          BEGIN IF3;}
<IF3>[\n\t]*{if}"("  {BEGIN IF3COND;}
<IF3COND>[^")"]*     {printf(" && %s){", yytext);
                                          if3cond = strdup(yytext);
                                          input();
                                          input();
                                          BEGIN IFBODY;}
<IFBODY>[^;]*      {printf("%s;\n}", yytext);
                                          input();
                                          BEGIN ELSE3;}
<ELSE3>["}"\n\t]*{else}"{"\n  {printf("else if(%s && %s){\n", if1cond, if2cond);
                                                           BEGIN ELSE3BODY;}
<ELSE3BODY>[^;]*   {printf("%s;\n}", yytext);
                                          input();
                                          BEGIN ELSE2;}
<ELSE2>["}"\n\t]*{else}"{"\n  {printf("else if(%s){\n", if1cond);
                                                           BEGIN ELSE2BODY;}
<ELSE2BODY>[^;]*   {printf("%s;\n}", yytext);
                                          input();
                                          BEGIN ELSE1;}
<ELSE1>["}"\n\t]*{else}"{"\n  {printf("else{\n");
                                                           BEGIN ELSE1BODY;}
<ELSE1BODY>[^;]*   {printf("%s;", yytext);
                                          input();
                                          BEGIN INITIAL;}

%%


int main(){

        yyin = fopen("nest.txt", "r");
        yylex();
        fclose(yyin);


        return 0;
}
