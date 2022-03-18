%{
#include <stdlib.h>
#include <stdio.h>
void yyerror(char *s);
typedef struct Element Element;
struct Element
{
    char *type;
	int index;
	char *nom;
    Element *suivant;
};

typedef struct Liste Liste;
struct Liste
{
    Element *premier;
};

Liste* initialisation();

int indexGlobal;
void insertion(Liste *liste, char *type, int index, char *nom);

void afficherListe(Liste *liste);

Liste *Tablesbl;

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
				| tINT tID tCOMA SDecl {insertion(Tablesbl, "int", indexGlobal,$2); afficherListe(Tablesbl);}
				| tCONST tID tCOMA SDecl {insertion(Tablesbl, "const", indexGlobal,$2); afficherListe(Tablesbl);}
				| tINT tID tEQUAL Expr tCOMA SDecl {insertion(Tablesbl, "int", indexGlobal,$2); afficherListe(Tablesbl);}
				| tCONST tID tEQUAL Expr tCOMA SDecl {insertion(Tablesbl, "const", indexGlobal,$2); afficherListe(Tablesbl);}
				;

SDecl 			: tID tCOMA SDecl {insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1); afficherListe(Tablesbl);}
				| tID tSEMC {insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1); afficherListe(Tablesbl);}
				| tID tEQUAL Expr tCOMA SDecl {insertion(Tablesbl, Tablesbl->premier->type, indexGlobal,$1); afficherListe(Tablesbl);}
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

Calcul			: Expr  { printf("> %d\n", $1); }
				| tID tEQUAL Expr  { insertion(Tablesbl, "int", indexGlobal,$1); afficherListe(Tablesbl); } 
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
				| tID { ;}
				| tNB { $$ = $1; } 
				;
				
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }

Liste *initialisation()
{
    Liste *liste = malloc(sizeof(*liste));
    Element *element = malloc(sizeof(*element));

    if (liste == NULL || element == NULL)
    {
        exit(EXIT_FAILURE);
    }
	element->type = NULL;
	element->index = 0;
	element->nom = NULL;
    element->suivant = NULL;
    liste->premier = element;

    return liste;
}

void insertion(Liste *liste, char *type, int index, char *nom)
{

		Element *nouveau = malloc(sizeof(*nouveau));
		if (liste == NULL || nouveau == NULL)
		{
			
			exit(EXIT_FAILURE);
		}
		if (indexGlobal == 0)
			{
				liste->premier->type = type;
				liste->premier->nom  = nom;
				indexGlobal++;
			}
		else{
		nouveau->type = type;
		nouveau->index = index;
		nouveau->nom = nom;

		/* Insertion de l'élément au début de la liste */
		nouveau->suivant = liste->premier;
		liste->premier = nouveau;
		indexGlobal++;
		}
		
}


void afficherListe(Liste *liste)
{
    if (liste == NULL)
    {
        exit(EXIT_FAILURE);
    }

    Element *actuel = liste->premier;

    while (actuel != NULL)
    {
		printf("%s ", actuel->nom);
		printf("%s ", actuel->type);
		printf("%d -> ", actuel->index);
        actuel = actuel->suivant;
    }
    printf("NULL\n");
}

int main(void) {
  printf("Programme\n"); // yydebug=1;
  yyparse();
  return 1;
}
