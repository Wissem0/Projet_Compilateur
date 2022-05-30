#ifndef _SYMBOL_H
#define _SYMBOL_H

#define MAX_SIZE 10000
typedef struct Element Element;
struct Element
{
    char *type;
	int adresse;
    int profondeur;
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


void insertion(Liste *liste, char *type, int adresse, char *nom, int profondeur);

void afficherListe(Liste *liste);

int adresse(Liste* liste,char *nom);

int adresse_length(Liste* liste,int length);

void supression (Liste *liste);

int length_file (FILE *F);

void supressionProfondeur (Liste *liste , int profondeur);

void deletePro(Liste *liste, int key) ;












#endif