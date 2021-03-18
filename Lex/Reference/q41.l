%{ 
    #include <bits/stdc++.h>
    using namespace std;

    // A segment is one of the 3 parts of the for loop
    vector<string> segments;
    string currentSegmentString;

    // Traversing inside a string
    bool isInString = false;

    // Traversing inside the paranthesis of a for loop declaration
    bool isInForLoop = false;

    // Number of unclosed braces
    int currentBrace = 0;

    // Stack of the increment statement and the brace level at which the original for loop occured
    stack<pair<string,int>> increments;

    // Remove leading white spaces in segments
    void cleanSegments() {
        vector<string> tSegments;
        for (auto it : segments) {
            int index = 0;
            while (it[index] == ' ' && index != it.length()) {
                index++;
            }
            if (index != it.length()) {
                tSegments.push_back(it.substr(index, it.length() - index));
            }
        }
        segments = tSegments;
    }

    void printInitialization() {
        cout << segments[0] << ";\n";
    }

    void printWhileCondition() {
        for (int i = 0; i < currentBrace; i++) cout << "    ";
        cout << "while (" << segments[1] << ") ";
    }

    // Print increment statement if the current brace level is same as that of previous unmatched for loop
    void printTopIncrement() {
        if (increments.size()) {
            pair<string, int> increment = increments.top();
            if (increment.second == currentBrace) {
                increments.pop();
                cout << "    " << increment.first << ";\n";
                for (int i = 0; i < currentBrace; i++) cout << "    ";
            }
        }
    }

    void pushIncrementer() {
        increments.push(make_pair(segments[2], currentBrace));
    }
%} 
  
%% 
for[' ']*[(] {
    if (!isInString) {
        isInForLoop = true;
    } else if (isInForLoop) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

\'[.]\' {
    if (isInForLoop) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

\\\" {
    if (isInForLoop) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

\" {
    isInString = !isInString;
    if (isInForLoop) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

; {
    if (isInForLoop) {
        if (isInString) currentSegmentString += yytext;
        else {
            segments.push_back(currentSegmentString);
            currentSegmentString = "";
        }
    } else {
        cout << yytext;
    }
}

[)] {
    if (isInForLoop) {
        if (isInString) currentSegmentString += yytext;
        else {
            segments.push_back(currentSegmentString);
            currentSegmentString = "";
            isInForLoop = false;
            cleanSegments();
            printInitialization();
            printWhileCondition();
            pushIncrementer();
            segments.clear();
        }
    } else {
        cout << yytext;
    }
}
[{] {
    currentBrace++;
    cout << yytext;
}

[}] {
    currentBrace--;
    printTopIncrement();
    cout << yytext;
}

. {
    if (isInForLoop) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

%% 

int yywrap(){}

int main(){ 
    extern FILE *yyin;
    yyin = fopen("input.c", "r"); 
    freopen("output.c", "w", stdout);
    yylex();
    return 0;
}
