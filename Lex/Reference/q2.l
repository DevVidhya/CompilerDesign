%{
    char stack[100];
    int tp = -1;
    char top();
    void pop();
    void push(char c);
    int empty();
    int precedance(char c);
%}

%%

[a-zA-Z1-9]+ fprintf(yyout, "%s", yytext);

[(] push(yytext[0]);

[)] {
    while(!empty() && top() != '(') {
        fprintf(yyout, "%c", top());
        pop();
    }
    if(!empty() && top() == '(')
        pop();
}

[+\-\*\/\^] {
    while(!empty() && precedance(yytext[0]) <= precedance(top())) {
        fprintf(yyout, "%c", top());
        pop();
    }
    push(yytext[0]);
}

[\n] {
    while(!empty()) {
        fprintf(yyout, "%c", top());
        pop();
    }
    if(yytext[0] == '\n')
        fprintf(yyout, "\n");
}

%%

char top() {
    return stack[tp];
}

void pop() {
    tp--;
}

void push(char c) {
    tp++;
    stack[tp] = c;
}

int empty() {
    return tp < 0;
}

int precedance(char c) {
    if(c == '+' || c == '-')
        return 0;
    else if(c == '*' || c == '/')
        return 1;
    else if(c == '^')
        return 2;
    return -1;
}

int yywrap(){} 

int main() 
{ 
    extern FILE *yyin, *yyout; 
    yyin = fopen("input2.txt", "r"); 
    yyout = fopen("output2.txt", "w"); 
    
    yylex(); 
    while(!empty()) {
        fprintf(yyout, "%c", top());
        pop();
    }
    return 0; 
}