#include "mainParser.hpp"

int main(int argc, char const *argv[])
{
    mainParser parser;
    FILE* fp = fopen("input.txt","r");
    yy_run_parser(parser, fp);
    return 0;
}
