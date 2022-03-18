%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}
%union { int nb; char var; }
%token tFL tEQUAL tPO tPC tMINUS tADD tDIV tMUL tMAIN tIF tWHILE tFOR tBRAO tBRAC tRET 
tSEMC tELSE tINT tCONST tCOL tERROR tCOMP tCOMPG tCOMPL tCOMA tPRINTF
%token <nb> tNB
%token <var> tID
%type <nb> Expr DivMul Terme


%%
Main 			: tMAIN tPO tPC { printf("Main detecte\n");} Body
				{ printf("Prog detecte\n");}
				;

Body 			: tBRAO Declarations Ins tBRAC 
				;

Declarations  	: Decl Declarations
				|
				;

Decl 			: tINT tID tSEMC
				| tCONST tID tSEMC
				| tINT tID tEQUAL Expr tSEMC
				| tCONST tID tEQUAL Expr tSEMC
				| tINT tID tCOMA SDecl
				| tCONST tID tCOMA SDecl
				| tINT tID tEQUAL Expr tCOMA SDecl
				| tCONST tID tEQUAL Expr tCOMA SDecl
				;

SDecl 			: tID tCOMA SDecl
				| tID tSEMC
				| tID tEQUAL Expr tCOMA SDecl
				| tID tEQUAL Expr tSEMC
				;

Ins  			: Calculatrice  tSEMC Ins
	 			| Condition Ins
				| tPRINTF tPO tID tPC {printf(">>>>> %d\n", var[$3]);} Ins
				|
				;

Condition 		: tIF tPO Expr Operateur Expr tPC tBRAO Ins tBRAC tELSE tBRAO Ins tBRAC
				;

Operateur 		: tCOMP 
				| tCOMPG
				| tCOMPL
				;

Calculatrice 	: Calcul Calculatrice | Calcul 
				;

Calcul			: Expr  { printf("> %d\n", $1); }
				| tID tEQUAL Expr  { var[(int)$1] = $3; } 
				;

Expr 			: Expr tADD DivMul { $$ = $1 + $3; }
				| Expr tMINUS DivMul { $$ = $1 - $3; }
				| DivMul { $$ = $1; } 
				;

DivMul 			: DivMul tMUL Terme { $$ = $1 * $3; }
				| DivMul tDIV Terme { $$ = $1 / $3; }
				| Terme { $$ = $1; } 
				;

Terme 			: tPO Expr tPC { $$ = $2; }
				| tID { $$ = var[$1]; }
				| tNB { $$ = $1; } 
				;
				
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Programme\n"); // yydebug=1;
  yyparse();
  return 1;
}
