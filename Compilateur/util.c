#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include "util.h"

Liste_F *initialisation_F()
{
    Liste_F *liste = malloc(sizeof(*liste));
    Element_F *element = malloc(sizeof(*element));

    if (liste == NULL || element == NULL)
    {
        exit(EXIT_FAILURE);
    }   
	element->chaine = NULL;
    liste->premier = element;
    longueur_F = 0;
    return liste;
}


void insertion_F(Liste_F *liste, char *chaine)
{

        
            Element_F *nouveau = malloc(sizeof(*nouveau));
            Element_F *Temp;
            if (liste == NULL || nouveau == NULL)
            {
                
                exit(EXIT_FAILURE);
            }
            if (longueur_F == 0)
                {
                    liste->premier->chaine = (char *) malloc(50);
                    strcpy(liste->premier->chaine, chaine);
                    liste->premier->suivant = NULL;
                    longueur_F++;
                    printf("coucou1: %s\n", chaine);
                }
            else{
                nouveau->chaine = (char *) malloc(50);
                strcpy(nouveau->chaine, chaine);
                nouveau->suivant = NULL;
            if(longueur_F == 1){
                liste->premier->suivant = nouveau;
                longueur_F++;
                printf("coucou2: %s\n", chaine);
            }
            else{
            Temp = liste->premier;
            while (Temp->suivant != NULL)
                {
                Temp = Temp->suivant;
                }
            Temp->suivant = nouveau;
            }
            longueur_F++;
            }
}


void afficherListe_F(Liste_F *liste)
{
    if (liste == NULL)
    {
        exit(EXIT_FAILURE);
    }

    Element_F *actuel = liste->premier;

    while (actuel != NULL)
    {
		printf("%s -> ", actuel->chaine);
        actuel = actuel->suivant;
    }
    printf("NULL\n");
}

void appliquerJump(Liste_F *F,int labels[]){

    fclose(F);
    F = fopen("assembleur","r");
     struct stat sb;
    stat("assembleur", &sb);
    char *file_contents = malloc(sb.st_size);

    Liste_F *listeChaine;
    listeChaine = initialisation_F();
    while (fscanf(F, "%[^\n] ", file_contents) != EOF) {
        insertion_F(listeChaine, file_contents);
    }
    fclose(F);
    F = fopen("assembleur","w+");
    
    int index = 0;
    Element_F *actuel = listeChaine->premier;

    while (actuel != NULL)
    {
        if (labels[index] != 0)
            {
            printf("%s\n" , actuel->chaine);
            fprintf(F,"%s %d %d\n",actuel->chaine,index,labels[index]);
            }
        else{
        fprintf(F,"%s\n",actuel->chaine);
        }
        actuel = actuel->suivant;
        index++;
        
    }



}


