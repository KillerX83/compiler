%option noyywrap
%{
# include "helper.h"
# include "parser.h"
# include <stdlib.h>
extern void yyerror(const char *msg); 
%}
%%
";" |
"(" |
"+" |
"-" |
"*" |
"/" |
")" { return yytext[0]; }
">" { yylval.fn = 1; return CMP; }
"<" { yylval.fn = 2; return CMP; }
"<>" { yylval.fn = 3; return CMP; }
"=" { yylval.fn = 4; return CMP; }
">=" { yylval.fn = 5; return CMP; }
"<=" { yylval.fn = 6; return CMP; }
"do" { return DO; }
"for" { return FOR; }
"while" {return WHILE; }
"done" {return DONE; }
"if" {return IF; }
"then" {return THEN; }
"else" {return ELSE; }
":=" {return ASN;}
X{0,3}(V?I{0,3}|I(X|V)) {yylval.d = RomanToInt(yytext); return NUMBER;}	// ������� �����
[XVI]+ { printf("line %d: lexical error: NotRoman:%s\n", yylineno, yytext); } // ��������� ������� �����
[a-zA-Z][a-zA-Z0-9]* { yylval.s = lookup(yytext); return NAME; }	//�������������
0 {yylval.d = 0; return NUMBER;}	// ����
[1-9][0-9]* {yylval.d = atoi(yytext); return NUMBER; }	// ���������� �����
"//".*
\n { yylineno += 1;}		//���������� ������ ������ ��� ������ �� �������
[ \t] /* ���������� ������� � ��������� */
. { printf("line %d: lexical error: Mystery character:%c\n", yylineno, *yytext); }
%%