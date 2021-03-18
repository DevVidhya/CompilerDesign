%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    int yyerror();
%}

%token VAR NUM IF ELSE LE GE EQ NE OR AND TYPE
%right '='
%left OR AND
%left '<' '>' GE LE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'

%%

S   : ST {printf("Valid if-then-else Syntax. Input Accepted!"); exit(0);}

ST  : IF '(' EXP ')' DEF ELSEPART

ELSEPART  : ELSE DEF | ELSE IF '(' EXP ')' ELSEPART |
    ;

DEF : '{' BODY '}' | EXP ';' | ST
    ;

BODY : BODY BODY | EXP ';' | ST |
     ;

EXP   : VAR '=' EXP | TYPE VAR | TYPE VAR '=' EXP | EXP '+' EXP | EXP '-' EXP | EXP '*' EXP | EXP '/' EXP | EXP '<' EXP | EXP '>' EXP | EXP LE EXP | EXP GE EXP | EXP EQ EXP | EXP NE EXP | EXP OR EXP | EXP AND EXP | EXP '+' '+' | EXP '-' '-' | VAR | NUM
      ;


%%

int main() {
    yyparse();
}

int yyerror() {
    printf("\nInvalid if-then-else Syntax.\n");
}
