#include <unordered_map>
#include <iostream>
#include <string>
using namespace std;

#define MAXLINE 4096

int main() {
    unordered_map <string, int> m;
    char buf[MAXLINE];

    while(! cin.eof()) {
        cin.getline(buf, MAXLINE);
        ++m[buf];
    }
    for(unordered_map<string, int>::iterator it = m.begin(); it != m.end(); ++it) {
        cout << it->first << "\t" << it->second << endl;
    }
}

