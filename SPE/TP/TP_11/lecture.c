#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <pthread.h>

FILE* fichier = NULL;

struct cellule{
	char* nom;
	struct cellule* suivant;
};
typedef struct cellule* liste;

liste lg = NULL;

void ajouter(liste* l, char* nom){
	liste new_l= malloc(sizeof(liste));
	new_l->nom = malloc(sizeof(char)*(1+strlen(nom)));
	strcpy(new_l->nom,nom);
	new_l->suivant = *l;
	*l = new_l;
}

int taille(liste l){
	if(l == NULL)
		return 0;
	else
		return 1 + taille(l->suivant);
}

void vider(liste l){
	if(l != NULL){
		liste suivant = l->suivant;
		free(l->nom);
		free(l);
		vider(suivant);
	}
}

void *f(void *arg) {
	char* memoire_locale = malloc(sizeof(char)*20);
	
	while(fgets(memoire_locale,20,fichier) != NULL){
    		ajouter(&lg,memoire_locale);
	}
	free (memoire_locale);
	pthread_exit(NULL);
}

int main(int argc, char** argv) {

	fichier = fopen("noms","r");
	
	// Création du tableau des fils secondaires
	pthread_t travailleurs[8];
  
	// Création des fils secondaires
	for (int k = 0; k < 8; k++) {
		pthread_create(&travailleurs[k], NULL, f, NULL);
	}
  
	// Attente de la fin des fils secondaires
	for (int k = 0; k < 8; k++) {
		pthread_join(travailleurs[k], NULL);
	}
	
	fclose(fichier);
	printf("Le fichier contenait %d lignes.\n",taille(lg));
	vider(lg);
	
	return 0;
}
