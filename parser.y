%{
#include "unionToken.hpp"
#include "callbackHandler.hpp"

typedef void* yyscan_t;
int yylex(YYSTYPE *lvalp, yyscan_t yyscanner);
int yylex_init(yyscan_t* yyscanner);
int yyset_in(FILE *fp, yyscan_t yyscanner);
int yylex_destroy(yyscan_t yyscanner);
void yylex_setin(FILE* fp, yyscan_t yyscanner);
int yyget_lineno(yyscan_t yyscanner);
void yyerror(callbackHandler &cb, yyscan_t yyscanner, const char * msg);
%}

%defines
%pure-parser
%parse-param { callbackHandler &cb }
%parse-param { yyscan_t yyscanner }
%lex-param { yyscan_t yyscanner }


%token <StringType()> STRING
%token EOL

%token ERROR

%%

root:
	| STRING EOL	{ printf("=> root STRING EOL\n")}
	;

%%

void yyerror(callbackHandler &cb, yyscan_t yyscanner, const char * msg) {
	printf("Line %d: %s\n", yyget_lineno(yyscanner), msg);
}

void yy_run_parser(callbackHandler &cb, FILE *fp) {
	yyscan_t yyscanner;
	if (yylex_init(&yyscanner)) {
		printf("Failed to initialize scanner\n");
		return;
	}
	yyset_in(fp, yyscanner);
	printf("yy_run_parser started\n");
	yyparse(cb, yyscanner);
	printf("yy_run_parser stopped\n");
	yylex_destroy(yyscanner);
}
