%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    int yyerror();
%}

%token VAR NUM FOR LE GE EQ NE OR AND TYPE
%right '='
%left OR AND
%left '<' '>' GE LE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'

%%

S   : START {printf("Valid FOR Syntax. Input accepted!"); exit(0);}

START  : FOR '(' EXP ';' COND ';' EXP ')' DEF
       ;
DEF : '{' BODY '}' | EXP ';' | START
    ;

BODY : BODY BODY | EXP ';' | START |
     ;

EXP   : VAR '=' EXP | TYPE VAR | TYPE VAR '=' EXP | EXP '+' EXP | EXP '-' EXP | EXP '*' EXP | EXP '/' EXP | EXP '<' EXP | EXP '>' EXP | EXP LE EXP | EXP GE EXP | EXP EQ EXP | EXP NE EXP | EXP OR EXP | EXP AND EXP | EXP '+' '+' | EXP '-' '-' | VAR | NUM |
    ;

COND  : EXP'<'EXP | EXP'>'EXP | EXP LE EXP | EXP GE EXP | EXP EQ EXP | EXP NE EXP | EXP OR EXP | EXP AND EXP
    ;

%%

int main() {
    yyparse();
}

int yyerror() {
    printf("\nInvalid FOR Syntax.\n");
}
