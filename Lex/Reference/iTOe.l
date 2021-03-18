%{
	char ch='e';
%}
%%
[a-zA-Z]? {
             char input=yytext[0];
             if(input=='i')
             printf("%c",ch);
             else
             printf("%c",yytext[0]);
          } 
%%
int main()
{
   yylex();
}
