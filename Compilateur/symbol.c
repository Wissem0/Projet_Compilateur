#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol.h"

Liste *initialisation()
{
    Liste *liste = malloc(sizeof(*liste));
    Element *element = malloc(sizeof(*element));

    if (liste == NULL || element == NULL)
    {
        exit(EXIT_FAILURE);
    }
	element->type = NULL;
	element->adresse = 0;
	element->nom = NULL;
    element->suivant = NULL;
    liste->premier = element;

    return liste;
}


// Return 1 iff the noun is unique, Else  return 0
int unique(Liste *liste, char * nom)
{

printf("erreur111111111111111111111");
if (liste->premier == NULL)
{
    return 1;
}
else{

    Element *nouveau;
    nouveau = liste->premier;
    if (strcmp(nouveau->nom,nom) == 0)
        {
           return 0;
        }
    while ( nouveau->suivant != NULL)
    {
        if (strcmp(nouveau->nom,nom) == 0)
        {
            return 0;
        }

    }

    return 1;
    }
}

void insertion(Liste *liste, char *type, int adresse, char *nom)
{

       /* printf("erreur");
        if (unique(liste,nom) == 0)
        {
            printf("ERREUR the variable ID is not unique");
            EXIT_FAILURE;
        }*/
        
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
            nouveau->adresse = adresse;
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
		printf("%d -> ", actuel->adresse);
        actuel = actuel->suivant;
    }
    printf("NULL\n");
}


int adresse(Liste* liste,char *nom){
    if (liste  == NULL)
    {
        return -1;
    }
    else
    {
        Element *nouveau = liste->premier;
        while (nouveau !=NULL)
        {
            if (strcmp(nom,nouveau->nom) == 0)
            {
                return nouveau->adresse;
            }
        nouveau = nouveau->suivant;
        }
    return -1;
    }
}
