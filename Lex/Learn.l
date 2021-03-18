https://www.geeksforgeeks.org/lex-program-count-number-words/
https://www.geeksforgeeks.org/flex-fast-lexical-analyzer-generator/
https://codereview.stackexchange.com/questions/238352/lex-code-to-convert-c-for-and-do-while-loops-into-while-loops
https://stackoverflow.com/questions/28060645/a-lex-program-that-find-the-longest-string-and-then-reverse-it
https://www.geeksforgeeks.org/lex-program-to-check-whether-given-string-is-palindrome-or-not/

%{ 
#include<stdio.h> 
#include<string.h> 
int i = 0; 
%} 
  
/* Rules Section*/
%% 
([a-zA-Z0-9])*    {i++;} /* Rule for counting  
                          number of words*/
  
"\n" {printf("%d\n", i); i = 0;} 
%% 
  
int yywrap(void){} 
  
int main() 
{    
    // The function that starts the analysis 
    yylex(); 
  
    return 0; 
} 
