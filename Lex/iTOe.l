%%

i fprintf(yyout, "e");

%%

int yywrap(){} 

int main() 
{ 
    extern FILE *yyin, *yyout; 
    yyin = fopen("ip.txt", "r"); 
    yyout = fopen("op.txt", "w"); 
  
    yylex(); 
    return 0; 
} 
