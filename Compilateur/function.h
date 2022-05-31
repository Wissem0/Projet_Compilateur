#ifndef _FUNCTION_H
#define _FUNCTION_H

#define MAX_SIZE 10000
typedef struct Element_FUN Element_FUN;
struct Element_FUN
{
    char *id;
    int param;
	int adresse;
    int retour;
    int ligne;
    Element_FUN *suivant;
};

typedef struct Liste_FUN Liste_FUN;
struct Liste_FUN
{
    Element_FUN *premier;
};

int longueur_FUN;

Liste_FUN* initialisation_FUN();

void insertion_FUN(Liste_FUN *liste, char *id,int param, int adresse, int ligne);

void afficherListe_FUN(Liste_FUN *liste);

char* adresse_length_FUN(Liste_FUN* liste,int length);

void setRetour(Liste_FUN* liste,char *id, int retour);

void setParam(Liste_FUN* liste, FILE *F, char *id, int niveau, int param);

int getAdresse(Liste_FUN* liste,char *id);

int getRetour(Liste_FUN* liste,char *id);
#endif