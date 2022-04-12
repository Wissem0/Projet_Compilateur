#ifndef _SYMBOL_H
#define _SYMBOL_H


typedef struct Element Element;
struct Element
{
    char *type;
	int adresse;
	char *nom;
    Element *suivant;
};

typedef struct Liste Liste;
struct Liste
{
    Element *premier;
};

int indexGlobal;
int longueur;
int condition;
Liste* initialisation();


void insertion(Liste *liste, char *type, int adresse, char *nom);

void afficherListe(Liste *liste);

int adresse(Liste* liste,char *nom);

int adresse_length(Liste* liste,int length);

void supression (Liste *liste);

int length_file (FILE *F);














#endif