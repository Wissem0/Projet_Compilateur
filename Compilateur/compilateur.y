%{
#include <stdlib.h>
#include <stdio.h>
#include "symbol.h"

void yyerror(char *s);



Liste *Tablesbl;
FILE *F ;
int profondeur = 0;
int suiteCond = -1;
int patching = -1;
int labels[MAX_SIZE];
%}
%union { int nb; char *var; }
%token tFL tEQUAL tPO tPC tMINUS tADD tDIV tMUL tMAIN tFOR tBRAO tBRAC tRET 
tSEMC tELSE tINT tCONST tCOL tERROR tCOMP tCOMPG tCOMPL tCOMA tPRINTF
%token <nb> tNB tIF tWHILE 
%token <var> tID 
%type <nb> Expr 
%left tSEMC
%right tEQUAL tADD tMINUS tMUL tDIV


%%
Prog 			:  Main Functions;
Functions 		: Fun Functions
				| 
				;
Fun				: tINT tID tPO Param tPC tBRAO Ins tBRAC 

Param			: tINT tID SuiteParam;

SuiteParam		: tCOMA Param
				| 
				;	

Main 			: tMAIN tPO tPC { 
									Tablesbl = initialisation(); 
									F = fopen("assembleur","w+");
									indexGlobal = 0;
								}
								Body
								{ 
									deletePro(Tablesbl, profondeur);
								}
				;

Body 			: tBRAO  Ins tBRAC 
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
							insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1, profondeur);
						}  
						Suite

				| tID tEQUAL 
						{
							insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1, profondeur);
						}  
						Expr  Suite
				;

Ins  			: Aff Ins
	 			| Condition Ins
				| tPRINTF tPO tID tPC tSEMC
											{
											fprintf(F,"PRI [@%d]\n",adresse(Tablesbl,$3));		
											} 
				Ins
				| Boucle Ins
				| Declarations Ins
				|
				;

Declarations  	: Decl Declarations
				|
				;

Decl 			: tINT tID 		
								{
								insertion(Tablesbl, "int", indexGlobal,$2, profondeur);
 								} 
				Suite 
				| tCONST tID
							{
								insertion(Tablesbl, "const int", indexGlobal,$2, profondeur);
							}
							Suite 
				;
Boucle			: tWHILE tPO {
							rewind(F);
							int current = length_file(F);
							$1 = current;
							}
							Expr Operateur  Expr 
							{
							
							if (condition == 1)
								{
								fprintf(F,"EQU [@%d] [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
								}
							if (condition == 2)
								{
								fprintf(F,"SUP [@%d] [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
								}
							if (condition == 3)
								{
								fprintf(F,"INF [@%d] [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
								}
							fprintf(F,"JMPF \n");
						 	profondeur++;	
							supression(Tablesbl);
							supression(Tablesbl);	
							}
							tPC tBRAO  Ins 
							{

							fprintf(F,"JMP \n");	
							int current = length_file(F);
							patch(current, $1 + 1);
							patch($1 + 4,current+1);
							appliquerJump(F,labels);
							deletePro(Tablesbl, profondeur);
							profondeur--;
							}
							tBRAC
							;

Condition 		: tIF tPO Expr Operateur Expr 
											{
												if (condition == 1)
													{
														afficherListe(Tablesbl);
														fprintf(F,"EQU [@%d] [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
													}
												if (condition == 2)
													{
														fprintf(F,"SUP [@%d] [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
													}
												if (condition == 3)
													{
														fprintf(F,"INF [@%d] [@%d] [@%d] \n",adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur-1),adresse_length(Tablesbl,longueur));
													}
												rewind(F);
												int length = length_file(F);
												fprintf(F,"JMPF \n");
												$1 = length;
												profondeur++;
												supression(Tablesbl);
												supression(Tablesbl);

											}
											tPC tBRAO Ins 
											{
												
												rewind(F);
												int current = length_file(F);
												patching = $1;
												patch($1+1,current+1);
												$1 = current;
												suiteCond = current;
	
											} 
											tBRAC SuiteCond 										 
											;
								
SuiteCond 		: tELSE {
						patch(patching + 1,suiteCond+2);
						fprintf(F,"JMP \n");
						}tBRAO Ins
					{
					rewind(F);
					int current = length_file(F);
					patch(suiteCond +1,current+1);
					appliquerJump(F,labels);
					deletePro(Tablesbl, profondeur);
					profondeur--;
				}
				tBRAC
				| 
				{
					appliquerJump(F,labels);
					deletePro(Tablesbl, profondeur);
					profondeur--;
				}
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
				{

					fprintf(F,"COP [@%d] [@%d]\n",adresse(Tablesbl,$1), $3);
					supression(Tablesbl);
				}
Expr 			: tID 	{	
							insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,"Temp_Variable", profondeur);
							fprintf(F,"COP [@%d] [@%d]\n",Tablesbl->premier->adresse, adresse(Tablesbl,$1));
							$$ = indexGlobal-1;						
					  	}
				| tNB 	{
							insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,"Temp_Variable", profondeur);
							fprintf(F,"AFF [@%d] %d\n",indexGlobal-1,$1);
							$$ = indexGlobal-1;
						}
				| Expr tADD Expr
						{
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