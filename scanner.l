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

Digit       [0-9]
Integer     [-+]?{Digit}+
Floating    [-+]?{Digit}+\.{Digit}*
Alphabet    [_a-zA-Z]
Letter      [_a-zA-Z{Digit}]

%%

<INITIAL>"+" {
    return ADD;
}

<INITIAL>"-" {
    return SUB;
}

<INITIAL>{Integer} {
    yylval->Integer = atoi(yytext);
    printf("found token %d\n", atoi(yytext));
    return INTEGER;
}

<INITIAL>[\n|\r] {
    return ENDL;
}

<INITIAL>. {
    yylval->Character = yytext;
}

%%
