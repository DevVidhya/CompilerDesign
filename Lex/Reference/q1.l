%%

i fprintf(yyout, "e");

%%

int yywrap(){} 

int main() 
{ 
    extern FILE *yyin, *yyout; 
    yyin = fopen("input1.txt", "r"); 
    yyout = fopen("output1.txt", "w"); 
  
    yylex(); 
    return 0; 
} 