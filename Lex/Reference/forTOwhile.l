%{ 
#include<stdio.h>

    string getString(char *text) {
        string output;
        char *temp;
        for(temp = text; *temp != '\0'; temp++) {
            output += *temp;
        }
        return output;
    }

    bool forExp = false;
    bool insideForScope = false;
    string stmt0, stmt1, stmt2, stmtInsideForScope;
    int stmtNo = 0;

    map <char, int> varStack;

    void setDefaultVal() {
        forExp = false;
        insideForScope = false;
        stmt0 = "";
        stmt1 = "";
        stmt2 = "";
        stmtInsideForScope = "";
        stmtNo = 0;
    }
%} 
  
  
%%  

for[(] {
    if(!forExp)
    {
        forExp = true;
    } else stmtInsideForScope += "(";
}

[)] {
    if(forExp)
        forExp = false;
    else stmtInsideForScope += ")";
}

[;] {
    if(forExp) {
        stmtNo++;
    } else stmtInsideForScope += ";";
}

[{] {
    varStack['{']++;
    if(!insideForScope)
        insideForScope = true;
    else stmtInsideForScope += "{";
}


[}] {
    varStack['{']--;
    if(!varStack['{'])
        insideForScope = false;
    else stmtInsideForScope += "}";
}

. {
    if(forExp) {
        switch(stmtNo) {
            case 0:
                stmt0 += getString(yytext);
                break;
            case 1:
                stmt1 += getString(yytext);
                break;
            case 2:
                stmt2 += getString(yytext);
                break;
        }
    } else if(insideForScope)
        stmtInsideForScope += getString(yytext);
}



\n {
    cout<<stmt0<<";"<<endl;
    cout<<"while("<<stmt1<<" ) {\n"<<stmtInsideForScope<<endl<<stmt2<<";"<<endl<<"}\n";
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

