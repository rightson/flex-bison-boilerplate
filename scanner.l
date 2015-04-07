%{
#include <string>
#include "tokenValues.hpp"
#include "parser.bison.hpp"
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
	yylval->token.string_value = new std::string(yytext);
	printf("Word: %s\n", yylval->token.string_value->c_str());
}

{Space}+ {
	break;
}

. {
	return ERROR;
}

%%
