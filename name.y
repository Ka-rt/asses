%{

typedef char* string;

#define YYSTYPE string

%}

%token NAME EQ AGE

%%

file : record file

| record

;

record : NAME EQ AGE {

        printf("%s is %s years old!\n", $1, $3);

        int age = atoi($3);

        if (age < 11) printf("%s is a kid\n",$1);

        else if(age < 20) printf("%s is a teenager\n",$1);

        else if (age>=20) printf("%s is a adult\n",$1);

}

;

%%

int main()

{

yyparse();

return 0;

}

int yyerror(char *msg)

{

  printf("Error encountered: %s \n", msg);

}
