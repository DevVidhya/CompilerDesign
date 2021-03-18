%{
#include<stdio.h>
%}

%%
["i"]+ fprintf(yyout,"e");		
.|\n fprintf(yyout,"%s",yytext);	
%%

int yywrap()
{
return 1;
}

int main(void)
{
yyin=fopen("input.txt","r");		
yyout=fopen("output.txt","w");

yylex();
return 0;
}