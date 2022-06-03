%{
#include <stdlib.h>
#include <stdio.h>
#include "symbol.h"
#include "function.h"
#include "util.h"

void yyerror(char *s);



Liste *Tablesbl;
FILE *F ;
Liste_FUN *fun;
int profondeur = 0;
int suiteCond = -1;
int patching = -1;
int labels[MAX_SIZE];
char *Function;
char *Suiteparam;
void patch (int from, int to){
	labels[from] = to;
}
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
Prog 			:
				{
				Tablesbl = initialisation(); 
				F = fopen("assembleur","w+");
				indexGlobal = 0;
				fun = initialisation_FUN();
				}   
				Functions Main;
Functions 		: Fun 
					{	
					fprintf(F,"NOP\n");						
					} 
				Functions
				| 
				;
Fun				: tINT tID tPO
							{
							rewind(F);
							patching = length_file(F);	
							Function  = $2;
							insertion_FUN(fun, $2, -1, patching,0);
							deletePro(Tablesbl, profondeur);
							} 
				Param tPC CorpFunction
										
CorpFunction: 				tBRAO Ins tRET tID tSEMC
				 				{
								insertion(Tablesbl, "int", indexGlobal,"Temp_Variable", profondeur);	 
								setRetour(fun ,Function, adresse_length(Tablesbl,longueur));
								fprintf(F,"COP [@%d] [@%d]\n",getRetour(fun,Function), adresse(Tablesbl, $4));	
								supression(Tablesbl);
								fprintf(F,"JMP LR\n");	
								deletePro(Tablesbl, profondeur);
								afficherListe(Tablesbl);
								}
				tBRAC 
Param			: tINT tID
						{
						rewind(F);	
						insertion(Tablesbl, "int", indexGlobal,$2, profondeur);	
						insertion_FUN(fun,adresse_length_FUN(fun,longueur_FUN), 0, patching,length_file(F)+1);	
						fprintf(F,"COP [@%d] \n",adresse_length(Tablesbl,longueur));
						} SuiteParam 
				|
				;

SuiteParam		: tCOMA Param
				| 
				;	

Main 			: tMAIN tPO tPC
								Body
								{ 
									deletePro(Tablesbl, profondeur);
									printf("Prog Detected\n");
								}
				;

Body 			: tBRAO  Ins tBRAC 
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
				| FunCall Ins
				|
				;

Declarations  	: Decl Declarations
				|
				;

Decl 			: tINT tID 		
								{
								
								insertion(Tablesbl, "int", indexGlobal,$2, profondeur);
								if (strcmp( $2,"a" ) == 0)
								 {
									 afficherListe(Tablesbl);
								 }
 								} 
				Suite 
				| tCONST tID
							{							
							insertion(Tablesbl, "const int", indexGlobal,$2, profondeur);
							}
							Suite 
				;

Suite 			: tSEMC
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





FunCall			: tID tEQUAL tID tPO 
									{
									patching = 0;
									Function = $3;
									}
				 ParamCall tPC	tSEMC 
				 					{
									rewind(F);
									fprintf(F,"BL %d %d\n",length_file(F) + 1, getAdresse(fun, Function));
									fprintf(F,"COP [@%d] [@%d]\n",adresse(Tablesbl,$1), getRetour(fun, Function));
									}
				 
ParamCall:		tID
					{	
					insertion(Tablesbl, "int", indexGlobal,"Temp_Variable", profondeur);
					patching++;
					Suiteparam = $1;
					setParam(fun, F, Function, patching, adresse(Tablesbl,$1));
					fprintf(F,"COP [@%d] [@%d]\n", adresse_length(Tablesbl,longueur), adresse(Tablesbl,$1));
					supression(Tablesbl);
					} 
					SuiteParamCall
					
				;	

SuiteParamCall:	tCOMA ParamCall
				| 
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
							fprintf(F,"AFC [@%d] %d\n",indexGlobal-1,$1);
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


int main(void) {
  printf("Programme\n"); // yydebug=1;
  yyparse();
  return 1;
}