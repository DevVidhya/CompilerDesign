%{
	char stack[200];
	int count=0;
	void push(char);
	void pop();
        char top();
        int precedence(char);
%}
%%
[a-zA-Z]? {
             printf("%c",yytext[0]);
          }
[(\)\^\*\/\+\-] { 
                 char operator=yytext[0];
                 if(count==0||operator=='(')
                   push(operator);
                 else if(operator==')')
                 {
                   while(top()!='(')
                   {
                     printf("%c",top());
                     pop();
                   }
                   pop();
                 }
                 else if(precedence(operator)>=precedence(top()))
                   push(operator);
                 else if(precedence(operator)<=precedence(top()))
                 {
                   while(precedence(operator)<=precedence(top()))
                   {
                     printf("%c",top());
                     pop();
                   }
                 push(operator);
                 }
              }
[\n] {
       int i;
       for(i=count-1;i>=0;i--)
         if(stack[i]!='('&&stack[i]!=')')
           printf("%c",stack[i]);
       count=0;         
     }
           
%%
int main()
{
   yylex();
}

void pop()
{
 count--;
}

char top()
{
   return stack[count-1];
}
  
void push(char ch)
{
   stack[count]=ch;
   count++;
}

int precedence(char ch)
{
  switch(ch)
  {
    case '(':return 0;
    case ')':return 0;
    case '+':return 1;
    case '-':return 1;
    case '*':return 2;
    case '/':return 2;
    case '^':return 3;
  }
}
