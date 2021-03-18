
%{
    #include <bits/stdc++.h>
    using namespace std;

    // helper function for precedence
    int prec(char c) 
    {
        if(c == '&') 
        return 3; 
        else if(c == '|') 
        return 2; 
        else
        return -1; 
    } 

    int prec(string c) 
    { 
        return prec(c[0]);
    } 

    string ans;
    stack<string>st;
%}

%%
"if"[' ']*"(" ;

[a-zA-Z]+ {
    ans += yytext;
}

"(" {
    st.push(yytext);
}

")"[' ']*"{"[ \t\n]*"}" {
    ;
}

")" {
    while(st.top()!="$" && st.top()!="("){
        ans += st.top(); st.pop();
    } 

    if(st.top()=="("){
        st.pop();
    }else{
        cout<<"Invalid\n";
    }
}

[&|] {

    while(st.top()!="$" && prec(yytext)<= prec(st.top())){
        ans+= st.top(); st.pop();
    }
    st.push(yytext);
}

" " ;

%%

int yywrap(){
    return 1;
}

string process(string res){
    stack<string>st;

    for(int i=0;i<res.size();i++){
        if(res[i]=='|'){
            if(!st.size()) return "Invalid";
            string r1 = st.top(); st.pop();
            if(!st.size()) return "Invalid";
            string r2 = st.top(); st.pop();

            st.push(r1 + "else " + r2);
        }else if(res[i]=='&'){
            if(!st.size()) return "Invalid";
            string r1 = st.top(); st.pop();
            if(!st.size()) return "Invalid";
            string r2 = st.top(); st.pop();

            r1.pop_back();
            st.push(r1 + r2 + "\n}");
        }else{
            st.push("if("+string(1,res[i])+"){\n}");
        }
    }

    return st.top();
}

int main(){
    st.push("$");
    yylex();
    while(st.top()!="$"){
        ans += st.top(); st.pop();
    }

    cout<<process(ans)<<"\n";
    return 0;
}
