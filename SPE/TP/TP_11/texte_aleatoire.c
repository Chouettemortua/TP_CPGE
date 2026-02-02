#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

FILE* fichier = NULL;


int main(int argc, char** argv) {

	srand(time(NULL));
	
	fichier = fopen("noms","w");
	if(fichier == NULL){
		printf("Erreur : le fichier n'a pas pu être créé.\n");
		return 0;
	}
	
	char* nb_char = malloc(strlen(argv[1])*sizeof(char));
	strcpy(nb_char,argv[1]);
	int nb = atoi(nb_char);
	free(nb_char);
	
	for(int i = 0 ; i < nb ; i++){
		int j = rand()%19;
		for(int k = 0 ; k < j ; k++)
		{
			if(fputc(33+rand()%68, fichier) == EOF){
				printf("Erreur : impossible d'écrire dans le fichier\n");
			}
		}
		if(fputc('\n', fichier) == EOF){
				printf("Erreur : impossible d'écrire dans le fichier\n");
			}
	}
	
	fclose(fichier);
	return 0;
}
