#include "mainParser.hpp"

int main(int argc, char const *argv[])
{
    mainParser parser;
    yy_file_parser(parser, fopen("input.txt","r"));
    yy_string_parser(parser, "123 + 456 \n\0");
    return 0;
}
