#include <stdio.h>

class mainParser {
    public:
        const int add(const int a, const int b) { return a+b; }
        const int sub(const int a, const int b) { return a-b; }
};

extern void yy_run_parser(mainParser &parser, FILE *fp);
