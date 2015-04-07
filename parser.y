%{
#include "tokenValues.hpp"
#include "mainParser.hpp"

typedef void* yyscan_t;
int yylex(YYSTYPE *lvalp, yyscan_t yyscanner);
int yylex_init(yyscan_t* yyscanner);
int yyset_in(FILE *fp, yyscan_t yyscanner);
int yylex_destroy(yyscan_t yyscanner);
void yylex_setin(FILE* fp, yyscan_t yyscanner);
int yyget_lineno(yyscan_t yyscanner);
void yyerror(mainParser &parser, yyscan_t yyscanner, const char * msg);
%}

%defines
%require "2.3"
%pure-parser
%parse-param { mainParser &parser }
%parse-param { yyscan_t yyscanner }
%lex-param { yyscan_t yyscanner }


%token <token.string_value> STRING
%token EOL

%token ERROR

%%

root:
	| STRING EOL	{ printf("=> root STRING EOL\n")}
	;

%%

void yyerror(mainParser &parser, yyscan_t yyscanner, const char * msg) {
	printf("Line %d: %s\n", yyget_lineno(yyscanner), msg);
}

void yy_run_parser(mainParser &parser, FILE *fp) {
	yyscan_t yyscanner;
	if (yylex_init(&yyscanner)) {
		printf("Failed to initialize scanner\n");
		return;
	}
	yyset_in(fp, yyscanner);
	printf("yy_run_parser started\n");
	yyparse(parser, yyscanner);
	printf("yy_run_parser stopped\n");
	yylex_destroy(yyscanner);
}
