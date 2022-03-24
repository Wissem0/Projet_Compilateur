%{
#include <stdlib.h>
#include <stdio.h>
#include "symbol.h"

void yyerror(char *s);



Liste *Tablesbl;
File *F = fopen("assembleur","w");
%}
%union { int nb; char *var; }
%token tFL tEQUAL tPO tPC tMINUS tADD tDIV tMUL tMAIN tIF tWHILE tFOR tBRAO tBRAC tRET 
tSEMC tELSE tINT tCONST tCOL tERROR tCOMP tCOMPG tCOMPL tCOMA tPRINTF
%token <nb> tNB
%token <var> tID
%type <nb> Expr DivMul Terme


%%
Main 			: tMAIN tPO tPC { 
								printf("Main detecte\n"); 
								Tablesbl = initialisation(); 
								indexGlobal =0;}
								Body
				{ printf("Prog detecte\n");}
				;

Body 			: tBRAO Declarations Ins tBRAC 
				;

Declarations  	: Decl Declarations
				|
				;

Decl 			: tINT tID tSEMC {insertion(Tablesbl, "int", indexGlobal,$2); afficherListe(Tablesbl);}
				| tCONST tID tSEMC {insertion(Tablesbl, "const", indexGlobal,$2); afficherListe(Tablesbl);}
				| tINT tID tEQUAL Expr tSEMC {insertion(Tablesbl, "int", indexGlobal,$2); afficherListe(Tablesbl);}
				| tCONST tID tEQUAL Expr tSEMC {insertion(Tablesbl, "const", indexGlobal,$2); afficherListe(Tablesbl);}
				| tINT tID  {insertion(Tablesbl, "int", indexGlobal,$2); afficherListe(Tablesbl);} tCOMA SDecl
				| tCONST tID  {insertion(Tablesbl, "const", indexGlobal,$2); afficherListe(Tablesbl);} tCOMA SDecl
				| tINT tID tEQUAL Expr  {insertion(Tablesbl, "int", indexGlobal,$2); afficherListe(Tablesbl);} tCOMA SDecl
				| tCONST tID tEQUAL Expr  {insertion(Tablesbl, "const", indexGlobal,$2); afficherListe(Tablesbl);} tCOMA SDecl
				;

SDecl 			: tID  {insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1); afficherListe(Tablesbl);} tCOMA SDecl
				| tID tSEMC {insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1); afficherListe(Tablesbl);}
				| tID tEQUAL Expr {insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1); afficherListe(Tablesbl);}  tCOMA SDecl
				| tID tEQUAL Expr tSEMC {insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1); afficherListe(Tablesbl);}
				;

Ins  			: Calculatrice  tSEMC Ins
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

Calculatrice 	: Calcul Calculatrice | Calcul 
				;

Calcul			: Expr  { ; }
				| tID tEQUAL Expr  { insertion(Tablesbl, "int", indexGlobal,$1); afficherListe(Tablesbl); } 
				;

Expr 			: Expr tADD DivMul { ; }
				| Expr tMINUS DivMul { ; }
				| DivMul { ; } 
				;

DivMul 			: DivMul tMUL Terme { ; }
				| DivMul tDIV Terme { ; }
				| Terme { ; } 
				;

Terme 			: tPO Expr tPC { ; }
				| tID { ;}
				| tNB { ; } 
				;
				
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }


int main(void) {
  printf("Programme\n"); // yydebug=1;
  yyparse();
  return 1;
}