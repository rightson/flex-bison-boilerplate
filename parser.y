%{
#include "tokenValues.hpp"
#include "mainParser.hpp"
#include "scanner.flex.hpp"

void yyerror(mainParser &parser, yyscan_t yyscanner, const char * msg);
%}

%defines
%require "2.3"
%pure-parser
%parse-param { mainParser &parser }
%parse-param { yyscan_t yyscanner }
%lex-param { yyscan_t yyscanner }

%token <Integer> INTEGER
%token LQUOTE
%token RQUOTE
%left ADD SUB
%left MUL DIV
%left COMMA DOT
%token ENDL

%%

calc        :
            |   calc expression ENDL        { printf("=> calc expression ENDL \n")}
            ;

expression  :   INTEGER                     { printf(" -> INTEGER %d\n", $1); }
            |   expression ADD expression   { printf(" -> expression ADD expression %d\n", parser.add($1.Integer, $3.Integer)); }
            |   expression SUB expression   { printf(" -> expression / expression %d\n", parser.sub($1.Integer, $3.Integer)); }
            ;

%%

void yyerror(mainParser &parser, yyscan_t yyscanner, const char * msg) {
    printf("Line %d: %s\n", yyget_lineno(yyscanner), msg);
}

void yy_file_parser(mainParser &parser, FILE *fp) {
    yyscan_t yyscanner;
    if (yylex_init(&yyscanner)) {
        printf("Failed to initialize scanner\n");
        return;
    }
    yyset_in(fp, yyscanner);
    printf("yy_file_parser started\n");
    yyparse(parser, yyscanner);
    printf("yy_file_parser stopped\n");
    yylex_destroy(yyscanner);
}

void yy_string_parser(mainParser &parser, const std::string &buffer) {
    yyscan_t yyscanner;
    if (yylex_init(&yyscanner)) {
        printf("Failed to initialize scanner\n");
        return;
    }
    YY_BUFFER_STATE bp;
    printf("yy_string_parser started\n");
    bp = yy_scan_string(buffer.c_str(), yyscanner);
    yy_switch_to_buffer(bp, yyscanner);
    yyparse(parser, yyscanner);
    yy_flush_buffer(bp, yyscanner);
    yy_delete_buffer(bp, yyscanner);
    printf("yy_string_parser stopped\n");
    yylex_destroy(yyscanner);
}