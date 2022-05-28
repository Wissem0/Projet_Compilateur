%{
#include <stdlib.h>
#include <stdio.h>
#include "symbol.h"

void yyerror(char *s);



Liste *Tablesbl;
FILE *F ;
int labels[MAX_SIZE];
%}
%union { int nb; char *var; }
%token tFL tEQUAL tPO tPC tMINUS tADD tDIV tMUL tMAIN tWHILE tFOR tBRAO tBRAC tRET 
tSEMC tELSE tINT tCONST tCOL tERROR tCOMP tCOMPG tCOMPL tCOMA tPRINTF
%token <nb> tNB tIF
%token <var> tID 
%type <nb> Expr 
%left tSEMC
%right tEQUAL tADD tMINUS tMUL tDIV


%%
Main 			: tMAIN tPO tPC { 
									printf("Main detecte\n"); 
									Tablesbl = initialisation(); 
									F = fopen("assembleur","w+");
									indexGlobal = 0;
								}
								Body
								{ 
									printf("Prog detecte\n");
								}
				;

Body 			: tBRAO Declarations Ins tBRAC 
				;

Declarations  	: Decl Declarations
				|
				;

Decl 			: tINT tID {
								supression(Tablesbl);
								insertion(Tablesbl, "int", indexGlobal,$2);
								afficherListe(Tablesbl);
 							} 
							Suite 
				| tCONST tID{
								supression(Tablesbl);
								insertion(Tablesbl, "const int", indexGlobal,$2);
								afficherListe(Tablesbl);
							}
							Suite 
				;
Suite 			: tSEMC
				{
					fprintf(F,"COP [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
					supression(Tablesbl);
				}
				| tCOMA SDecl
				| tEQUAL Expr tSEMC
				{
					fprintf(F,"COP [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
					supression(Tablesbl);
				}
				| tEQUAL Expr tCOMA 
				{
					fprintf(F,"COP [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
					supression(Tablesbl);
				}
				SDecl
				;

SDecl 			: tID  {
							insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1);
							afficherListe(Tablesbl);
						}  
						Suite

				| tID tEQUAL 
						{
							insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1);
							afficherListe(Tablesbl);
						}  
						Expr  Suite
				;

Ins  			: Aff Ins
	 			| Condition Ins
				| tPRINTF tPO tID tPC {;} Ins
				|
				;

Condition 		: tIF tPO Expr Operateur Expr 
											{
												fprintf(F,"SOU [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
												rewind(F);
												int length = length_file(F);
												if (condition == 1)
													fprintf(F,"JMPF \n");
												$1 = length;
											}
											tPC tBRAO Ins 
											{
												
												rewind(F);
												int current = length_file(F);
												printf(" LONGEUR FICHIER %d\n\n",current);
												patch($1,current+2);

												fprintf(F,"JMP \n");
												$1 = current;
											} 
											tBRAC tELSE tBRAO Ins
											{
												rewind(F);
												int current = length_file(F);
												patch($1,current+1);
												for (int i =0 ; i < 20 ; i ++){
													printf("FROM %d TO %d\n",i,labels[i]);
												}
												appliquerJump(F,labels);

											}
											 tBRAC
											 
											;
								
   
Operateur       : tCOMP	
						{
						condition = 1;
						}						
				| tCOMPG
						{
						condition = 2;
						}	
				| tCOMPL
						{
						condition = 3;
						}	
				;

Aff             : tID tEQUAL Expr tSEMC
Expr 			: tID 	{	
							insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,"Temp_Variable");
							fprintf(F,"COP [@%d] [@%d]\n",Tablesbl->premier->adresse, adresse(Tablesbl,$1));
							$$ = indexGlobal-1;						
					  	}
				| tNB 	{
							insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,"Temp_Variable");
							fprintf(F,"AFF [@%d] %d\n",indexGlobal-1,$1);
							$$ = indexGlobal-1;
							printf("coucou\n");
							afficherListe(Tablesbl);
						}
				| Expr tADD Expr
						{
							printf("ADD------------------------\n");
							afficherListe(Tablesbl);
							fprintf(F,"ADD [@%d] [@%d] [@%d]\n",$1,$1,$3 );
							$$ = $1;
							supression(Tablesbl);
			
						}
				| Expr tMINUS Expr
						{
							fprintf(F,"SOU [@%d] [@%d] [@%d]\n",$1,$1,$3 );
							$$ = $1;
							supression(Tablesbl);	
						}
				| Expr tMUL Expr
						{
							fprintf(F,"MUL [@%d] [@%d] [@%d]\n",$1,$1,$3 );
							$$ = $1;
							supression(Tablesbl);	
						}
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }

void patch (int from, int to){
	labels[from] = to;
}
int main(void) {
  printf("Programme\n"); // yydebug=1;
  yyparse();
  return 1;
}