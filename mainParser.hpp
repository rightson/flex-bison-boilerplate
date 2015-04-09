#include <string>
#include <stdio.h>

class mainParser {
    public:
        const int add(const int a, const int b) { return a+b; }
        const int sub(const int a, const int b) { return a-b; }
};

extern void yy_file_parser(mainParser &parser, FILE *fp);
extern void yy_string_parser(mainParser &parser, const std::string &buffer);
