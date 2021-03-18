%{ 
#include<stdio.h> 
#include<string.h> 
char *ptr1 = NULL,*ptr2 = NULL,*ptr3 = NULL,*ptr4 = NULL,args[100][200],name[20],body[30],argument[30];
int i = 0,j = 0,count = 0;
%} 

letter 			[a-zA-Z]
digit 			[0-9]
id 			{letter}({letter}|{digit})*
number 			[+-]?{digit}+(\.{digit}+)?(E[+-]?{digit}+)?
operator 		[\+\*\/\-]
term 			(({number}|{id}){operator})?({id}|{number})({operator}({number}|{id}))?
arithmetic 		({term}{operator})*{term}
parameters 		({id}\,)*{id}?
procedure 		{id}\({parameters}\)
delimimter 		[ \t\n]
whitespace 		{delimimter}+
%% 

#define{whitespace}{procedure}{whitespace}{arithmetic} {
	count = 0;
	printf("Macro: %s\n",yytext);
	ptr1 = strchr(yytext,' ');
	ptr1++;
	i = 0;
	while(ptr1[i] != '(')
	{
		name[i] = ptr1[i];
		i++;
	}
	name[i] = '\0';
	printf("Name: %s\n",name);
        i = 0;
	ptr2 = strrchr(yytext,' ');
	ptr2++;
	while(ptr2[i] != '\0')
	{
		body[i] = ptr2[i];
		i++;
	}
	body[i] = '\0';
	printf("Body: %s\n",body);
	i = 0;	
	ptr3 = strchr(yytext,'(');
	ptr3++;
	while(ptr3[i] != ')')
	{
		argument[i] = ptr3[i];
		i++;
	}
	argument[i] = '\0';
	i = 0;
	ptr4 = strtok(argument,",");
	while(ptr4 != NULL)	
	{
		strcpy(args[i++],ptr4);
		count++;
		ptr4 = strtok(NULL,",");
	}
	printf("Arguments: ");
	for(i = 0;i<count;i++)
	printf("%s ",args[i]);
	printf("\n");
	fprintf(yyout,"int %s(",name);
	for(i = 0;i<count-1;i++)
	fprintf(yyout,"int %s, ",args[i]);
	if(count != 0)
	fprintf(yyout,"int %s",args[count-1]);
	fprintf(yyout,")\n{\n\treturn %s;\n}\n",body);
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
	yyin = fopen("input.txt","r");
	yyout = fopen("output.txt","w");
	yylex(); 
} 

