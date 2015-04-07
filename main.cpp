#include "callbackHandler.hpp"

int main(int argc, char const *argv[])
{
    callbackHandler cb;
    FILE* fp = fopen("example.txt","r");
    yy_run_parser(cb, fp);
    return 0;
}
