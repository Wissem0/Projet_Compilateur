#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include "function.h"
#include "util.h"
Liste_FUN* initialisation_FUN()
{
    Liste_FUN *liste = malloc(sizeof(*liste));
    Element_FUN *element = malloc(sizeof(*element));

    if (liste == NULL || element == NULL)
    {
        exit(EXIT_FAILURE);
    }   
	element->id = NULL;
    element->param = -1;
	element->adresse = -1;
    element->retour = -1;
    element->ligne = -1;
    element->suivant = NULL;
    liste->premier = element;
    longueur_FUN = 0;
    return liste;
}

void insertion_FUN(Liste_FUN *liste, char *id,int param, int adresse, int ligne){

    Element_FUN *nouveau = malloc(sizeof(*nouveau));
            Element_FUN *Temp;
            if (liste == NULL || nouveau == NULL)
            {
                
                exit(EXIT_FAILURE);
            }
            if (longueur_FUN == 0)
                {
                    liste->premier->id = (char *) malloc(50);
                    strcpy(liste->premier->id, id);
                    liste->premier->param = param;
                    liste->premier->adresse = adresse;
                    liste->premier->ligne = ligne;
                    liste->premier->suivant = NULL;
                    longueur_FUN++;
                }
            else{
                nouveau->id = (char *) malloc(50);
                strcpy(nouveau->id, id);
                nouveau->param = param;
                nouveau->adresse = adresse;
                nouveau->ligne = ligne;
                nouveau->suivant = NULL;
            if(longueur_FUN == 1){
                liste->premier->suivant = nouveau;
                longueur_FUN++;
            }
            else{
            Temp = liste->premier;
            while (Temp->suivant != NULL)
                {
                Temp = Temp->suivant;
                }
            Temp->suivant = nouveau;
            }
            longueur_FUN++;
            }

}

void afficherListe_FUN(Liste_FUN *liste)
{
    if (liste == NULL)
    {
        exit(EXIT_FAILURE);
    }

    Element_FUN *actuel = liste->premier;

    while (actuel != NULL)
    {
		printf("%s ", actuel->id);
		printf("%d ", actuel->param);
        printf("%d ", actuel->adresse);
        printf("%d  ", actuel->retour);
        printf("%d ->", actuel->ligne);
        actuel = actuel->suivant;
    }
    printf("NULL\n");
}

char* adresse_length_FUN(Liste_FUN* liste,int length){
    if (liste  == NULL)
    {
        return NULL;
    }
    else
    {
        int index = 1;
        Element_FUN *nouveau = liste->premier;
        while (nouveau !=NULL && index <= length-2)
        {
        index++;
        nouveau = nouveau->suivant;
        }
    return nouveau->id;
    }
}

void setRetour(Liste_FUN* liste,char *id, int retour){

 if (liste == NULL)
    {
        exit(EXIT_FAILURE);
    }

    Element_FUN *actuel = liste->premier;;
    while (actuel != NULL)
    {
        if (strcmp(actuel->id, id) == 0){
            actuel->retour = retour;
        }
        actuel = actuel->suivant;
    }

}

void setParam(Liste_FUN* liste, FILE *F, char *id, int niveau, int param){
     Element_FUN *retour = liste->premier;
     int index = 0;
     int trouve = 0;
     
    while (retour != NULL && index <= niveau)
    {
        if (strcmp(retour->id, id) == 0){
            index++;
            if (trouve == 1)
                {
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
                int index = 1;
                Element_F *actuel = listeChaine->premier;
                while (actuel != NULL)
                    {
                        if ( retour->ligne == index && retour->ligne !=-999999)
                            {
                            fprintf(F,"%s[@%d]\n",actuel->chaine, param);
                            retour->ligne=-999999;
                            }
                        else{
                        fprintf(F,"%s\n",actuel->chaine);
                        }
                        actuel = actuel->suivant;
                        index++;
                        
                    }
                }
            else
                {
                trouve = 1;
                }
        }		
        retour = retour->suivant;
    }
}

int getAdresse(Liste_FUN* liste,char *id){
    Element_FUN *actuel = liste->premier;
    while (actuel != NULL)
    {
        if (strcmp(actuel->id, id) == 0 ){
            return actuel->adresse + 1;
        }
        actuel = actuel->suivant;
    }
    return -1;
}

int getRetour(Liste_FUN* liste,char *id){
    Element_FUN *actuel = liste->premier;
    while (actuel != NULL)
    {
        if (strcmp(actuel->id, id) == 0 ){
            return actuel->retour ;
        }
        actuel = actuel->suivant;
    }
    return -1;
}


