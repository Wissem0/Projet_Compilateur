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
    element->profondeur = 0;
	element->nom = NULL;
    element->suivant = NULL;
    liste->premier = element;
    longueur = 0;
    condition = 0;
    return liste;
}


// Return 1 iff the noun is unique, Else  return 0
int unique(Liste *liste, char * nom)
{

if (liste->premier == NULL || liste == NULL || liste->premier->type == NULL)
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
    while ( nouveau != NULL)
    {
        if (strcmp(nouveau->nom,nom) == 0)
        {
            return 0;
        }
    nouveau = nouveau->suivant;
    }

    return 1;
    }
}

void insertion(Liste *liste, char *type, int adresse, char *nom, int profondeur)
{
            if (unique(liste, nom) == 0 && strcmp(nom, "Temp_Variable")!= 0)
            {
                printf("WARNING Variable %s déja utilisée\n",nom);
                exit(EXIT_FAILURE);
            }
            else{
            Element *nouveau = malloc(sizeof(*nouveau));
            if (liste != NULL && liste->premier == NULL)
            {    
                Element *element = malloc(sizeof(*element));
                if (liste == NULL || element == NULL)
                {
                    exit(EXIT_FAILURE);
                }   
                element->type = NULL;
                element->adresse = 0;
                element->profondeur = 0;
                element->nom = NULL;
                element->suivant = NULL;
                liste->premier = element;
                longueur = 0;
                            
            }

            if (longueur == 0)
                {
                    liste->premier->type = type;
                    liste->premier->nom  = nom;
                    liste->premier->adresse  = adresse;
                    indexGlobal++;
                    longueur++;
                }
            else{
            nouveau->type = type;
            nouveau->adresse = adresse;
            nouveau->profondeur = profondeur;
            nouveau->nom = nom;

            /* Insertion de l'élément au début de la liste */
            nouveau->suivant = liste->premier;
            liste->premier = nouveau;
            indexGlobal++;
            longueur++;
            }
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
        printf("%d ", actuel->profondeur);
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

int adresse_length(Liste* liste,int length){
    if (liste  == NULL)
    {
        return -1;
    }
    else
    {
        int index = longueur;
        Element *nouveau = liste->premier;
        while (nouveau !=NULL && index > length)
        {
        index--;
        nouveau = nouveau->suivant;
        }
    return nouveau->adresse;
    }
}


void supression (Liste *liste){

    if (liste != NULL && liste->premier != NULL )
    {
    liste->premier = liste->premier->suivant;
    longueur--;
    }

}

int length_file (FILE * F)
{
    char ch=5;
    int lines=0;
    fseek(F, 0, SEEK_SET);
    ch = fgetc(F);

    while(ch != EOF)
    {
        if(ch == '\n')
            {
            lines++;
            }
        ch = fgetc(F);
    }
        
    return lines;
}

void supressionProfondeur (Liste *liste , int profondeur){

    if (liste != NULL && liste->premier != NULL )
    {  
        Element *actuel = liste->premier;
        Element *suivant = liste->premier->suivant;
        if (suivant== NULL && actuel->profondeur == profondeur){
            liste->premier = NULL;
        }
        while (suivant != NULL){

        if (suivant->profondeur == profondeur)
            {
            actuel->suivant = suivant->suivant;
            suivant = actuel->suivant;
            }
            else{
                actuel = actuel->suivant;
                suivant = suivant->suivant;
            }
        
        }

}
}

void deletePro(Liste *liste, int key)
{
     
    // Store head node
    Element *temp = liste->premier;
    Element *prev = NULL;

    while (temp != NULL && temp->profondeur == key)
    {
        liste->premier = temp->suivant; // Changed head
        temp = liste->premier;
        
    }
    

    while (temp != NULL)
    {
        if (temp->profondeur == key)
        {
            
            prev->suivant = temp->suivant;
            temp = temp->suivant;
        }else{
            prev = temp;
            temp = temp->suivant;
        }
    }
     
}

