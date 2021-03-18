%{ 
    #include<bits/stdc++.h>
    using namespace std;

    string getStr(char *ch) {
        string op;
        char *t;
        for(t = ch; *t != '\0'; t++) {
            op += *t;
        }
        return op;
    }

    bool Exp = false;
    bool inScope = false;
    string n0, n1, n2, stInScope;
    int No = 0;

    map <char, int> Stack;

    void setDefaultVal() {
        Exp = false;
        inScope = false;
        n0 = "";
        n1 = "";
        n2 = "";
        stInScope = "";
        No = 0;
    }
%} 
  
  
%%  

for[(] {
    if(!Exp)
    {
        Exp = true;
    } else stInScope += "(";
}

[)] {
    if(Exp)
        Exp = false;
    else stInScope += ")";
}

[;] {
    if(Exp) {
        No++;
    } else stInScope += ";";
}

[{] {
    Stack['{']++;
    if(!inScope)
        inScope = true;
    else stInScope += "{";
}


[}] {
    Stack['{']--;
    if(!Stack['{'])
        inScope = false;
    else stInScope += "}";
}

. {
    if(Exp) {
        switch(No) {
            case 0:
                n0 += getStr(yytext);
                break;
            case 1:
                n1 += getStr(yytext);
                break;
            case 2:
                n2 += getStr(yytext);
                break;
        }
    } else if(inScope)
        stInScope += getStr(yytext);
}



\n {
    cout<<n0<<";"<<endl;
    cout<<"while("<<n1<<" ) {\n"<<stInScope<<endl<<n2<<";"<<endl<<"}\n";
    setDefaultVal();
}

%% 
int yywrap() 
{ 
    return 1; 
} 
int main() 
{
    yylex(); 
}
