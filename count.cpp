#include <tr1/unordered_map>
#include <iostream>
#include <string>
using namespace std;

#define MAXLINE 4096

int main() {
    std::tr1::unordered_map <std::string, int> m;
    char buf[MAXLINE];

    while(! cin.eof()) {
        std::cin.getline(buf, MAXLINE);
        ++m[buf];
    }
    for(std::tr1::unordered_map<std::string, int>::iterator it = m.begin(); it != m.end(); ++it) {
        std::cout << it->first << "\t" << it->second << std::endl;
    }
}

