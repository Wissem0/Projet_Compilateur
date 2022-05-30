#ifndef _UTIL_H
#define _UTIL_H

typedef struct Element_F Element_F;
struct Element_F
{
    char *chaine;
    Element_F *suivant;
};

typedef struct Liste_F Liste_F;
struct Liste_F
{
    Element_F *premier;
};
int longueur_F;


Liste_F* initialisation_F();

void insertion_F(Liste_F *liste, char *chaine);

void afficherListe_F(Liste_F *liste);

void appliquerJump(FILE *F,int labels[]);

void initialiserTableau( int labels[]);
#endif