%{
#include <string>
#include "unionToken.hpp"

#include "parser.bison.hpp"
#define YY_BREAK
#define ECHO
%}

%option reentrant bison-bridge
%option noyywrap yylineno
%option header-file="scanner.flex.hpp"

%x COMMENT
%x QSTRING

Space 		[\r\b\t\n ]
Alpha		[[:alpha:]]
DecDigit    [[:digit:]]
Word		({Alpha}|{DecDigit})+

%%


"/*" {
	BEGIN COMMENT;
}

{Word} {
	yylval->StringType() = new std::string(yytext);
	printf("Word: %s\n", yylval->token_value.string_value->c_str());
}

{Space}+ {
	break;
}

. {
	return ERROR;
}

%%
