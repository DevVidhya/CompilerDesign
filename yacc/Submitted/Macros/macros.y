%{ 
   #include <stdio.h> 
   #include <stdlib.h>
   int yylex();
   int yyerror();
%}

%token   MACRO VAR COMMA LPAR RPAR CHAR

%%

S : E {
    printf("Valid #define macros Syntax. Input Accepted! \n");
    exit(0);
}

E : MACRO VAR LPAR ARGS RPAR BODY | MACRO VAR LPAR RPAR BODY | MACRO VAR BODY
  ;

ARGS : VAR COMMA ARGS | VAR
     ;

BODY : CHAR | VAR | VAR BODY | LPAR BODY | RPAR | RPAR BODY| CHAR BODY
          ;

%%

int main() {
    yyparse();
}

int yyerror() {
    printf("\nInvalid #define macros Syntax.\n");
}
