#ifndef _SYMBOL_H
#define _SYMBOL_H


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

int indexGlobal;

Liste* initialisation();


void insertion(Liste *liste, char *type, int index, char *nom);

void afficherListe(Liste *liste);
















#endif