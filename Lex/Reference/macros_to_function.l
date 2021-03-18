%{ 
#include<stdio.h> 
#include<string.h> 
char *name = NULL,*body = NULL,args[100][200],function_name[20],function_body[30],*ar = NULL,*token = NULL,argument[30];
int i = 0,j = 0,count = 0;
%} 

delimimter 		[ \t\n]
whitespace 		{delimimter}+
letter 			[a-zA-Z]
digit 			[0-9]
id 				{letter}({letter}|{digit})*
number 			[+-]?{digit}+(\.{digit}+)?(E[+-]?{digit}+)?
operator 		[\+\*\/\-]
term 			(({number}|{id}){operator})?({id}|{number})({operator}({number}|{id}))?
arithmetic 		({term}{operator})*{term}
parameters 		({id}\,)*{id}?
procedure 		{id}\({parameters}\)
%% 

#define{whitespace}{procedure}{whitespace}{arithmetic} {
	count = 0;
	printf("Macro: %s\n",yytext);
	name = strchr(yytext,' ');
	name++;
	i = 0;
	while(name[i] != '(')
	{
		function_name[i] = name[i];
		i++;
	}
	function_name[i] = '\0';
	printf("Name: %s\n",function_name);
        i = 0;
	body = strrchr(yytext,' ');
	body++;
	while(body[i] != '\0')
	{
		function_body[i] = body[i];
		i++;
	}
	function_body[i] = '\0';
	printf("Body: %s\n",function_body);
	i = 0;	
	ar = strchr(yytext,'(');
	ar++;
	while(ar[i] != ')')
	{
		argument[i] = ar[i];
		i++;
	}
	argument[i] = '\0';
	i = 0;
	token = strtok(argument,",");
	while(token != NULL)	
	{
		strcpy(args[i++],token);
		count++;
		token = strtok(NULL,",");
	}
	printf("Arguments: ");
	for(i = 0;i<count;i++)
	printf("%s ",args[i]);
	printf("\n");
	fprintf(yyout,"int %s(",function_name);
	for(i = 0;i<count-1;i++)
	fprintf(yyout,"int %s, ",args[i]);
	if(count != 0)
	fprintf(yyout,"int %s",args[count-1]);
	fprintf(yyout,")\n{\n\treturn %s;\n}\n",function_body);
}
. fprintf(yyout,"%s",yytext);
%% 


int yywrap() 
{ 
	return 1; 
} 

int main() 
{ 
	extern FILE *yyin, *yyout; 
	char ipfile[100];
	char opfile[100];


	printf("Enter input file : ");
	scanf("%s",ipfile);
	printf("Enter output file: ");
	scanf("%s",opfile);
	yyin = fopen(ipfile,"r");
	yyout = fopen(opfile,"w");
	
		yylex(); 
} 

