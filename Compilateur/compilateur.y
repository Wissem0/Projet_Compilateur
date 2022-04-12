%{
#include <stdlib.h>
#include <stdio.h>
#include "symbol.h"

void yyerror(char *s);



Liste *Tablesbl;
FILE *F ;
%}
%union { int nb; char *var; }
%token tFL tEQUAL tPO tPC tMINUS tADD tDIV tMUL tMAIN tIF tWHILE tFOR tBRAO tBRAC tRET 
tSEMC tELSE tINT tCONST tCOL tERROR tCOMP tCOMPG tCOMPL tCOMA tPRINTF
%token <nb> tNB
%token <var> tID
%left tSEMC
%right tEQUAL tADD tMINUS tMUL tDIV


%%
Main 			: tMAIN tPO tPC { 
								printf("Main detecte\n"); 
								Tablesbl = initialisation(); 
								F = fopen("assembleur","w");
								indexGlobal =0;}
								Body
				{ printf("Prog detecte\n");}
				;

Body 			: tBRAO Declarations Ins tBRAC 
				;

Declarations  	: Decl Declarations
				|
				;

Decl 			: tINT tID {insertion(Tablesbl, "int", indexGlobal,$2); afficherListe(Tablesbl);} Suite 
				| tCONST tID {insertion(Tablesbl, "const int", indexGlobal,$2); afficherListe(Tablesbl);} Suite 
				;
Suite 			: tSEMC
				| tCOMA SDecl
				| tEQUAL Expr tSEMC
				| tEQUAL Expr tCOMA SDecl
				;

SDecl 			: tID  {insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1); afficherListe(Tablesbl);}  Suite
				| tID tEQUAL {insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1); afficherListe(Tablesbl);}  Expr  Suite
				;

Ins  			: Expr  tSEMC Ins
	 			| Condition Ins
				| tPRINTF tPO tID tPC {;} Ins
				|
				;

Condition 		: tIF tPO Expr Operateur Expr tPC tBRAO Ins tBRAC tELSE tBRAO Ins tBRAC
				;

Operateur 		: tCOMP 
				| tCOMPG
				| tCOMPL
				;

Expr 			: tID {printf("AFF adresse1:%d  adresse2:%d\n",Tablesbl->premier->adresse, adresse(Tablesbl,$1));}
				| tNB {printf("AFF adresse:%d %d\n ",Tablesbl->premier->adresse,$1);}
				| Expr tADD Expr
				| Expr tMINUS Expr
				| Expr tMUL Expr
				| Expr tDIV Expr
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }


int main(void) {
  printf("Programme\n"); // yydebug=1;
  yyparse();
  return 1;
}