%{ 
   #include <stdio.h> 
   #include <stdlib.h>
   int yylex();
   int yyerror();
%}

%token   NUM
%left    '+' '-'
%left    '*' '/'

%%

S : EXP {
    printf("Evaluated Value = %d\n", $$);
    return 0;
}

EXP : EXP EXP '+' { $$ = $1 + $2; } | EXP EXP '-' { $$ = $1 - $2; } | EXP EXP '*' { $$ = $1 * $2; } | EXP EXP '/' { $$ = $1 / $2; } | NUM { $$ = $1; }

%%

int main() {
    printf("Expression : 53+62/*35*\n");
    yyparse();
}

int yyerror() {
    printf("\nInvalid Expression\n");
}
