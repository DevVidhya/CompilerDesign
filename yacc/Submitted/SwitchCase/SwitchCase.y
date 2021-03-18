%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    int yyerror();
%}

%token VAR CHAR SWITCH CASE BREAK TYPE SEMICOLON COLON DEFAULT LPAR RPAR LBR RBR 

%%

S : START {printf("Valid Switch-Case Syntax. Input accepted!"); exit(0);}

START  : SWITCH LPAR VAR RPAR DEF
       ;

DEF : LBR BODY RBR
    ;

BODY : CASE VAR COLON OUTBLOCK BODY | DEFAULT COLON OUTBLOCK |
     ;

OUTBLOCK : LBR INBLOCK BREAK SEMICOLON RBR | LBR INBLOCK RBR | ST BREAK SEMICOLON | ST
      ;

INBLOCK : ST INBLOCK |
        ;

ST : CHAR ST | VAR ST | LPAR ST | RPAR ST | SEMICOLON

%%

int main() {
    yyparse();
}

int yyerror() {
    printf("\nInvalid Switch-Case Syntax.\n");
}
