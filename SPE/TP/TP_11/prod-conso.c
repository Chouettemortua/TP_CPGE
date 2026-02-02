#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <pthread.h>
#include <semaphore.h>
#include <time.h>

int* buffer = NULL;
int taille = 10;
int prochain_consomme = 0;
int prochain_produit = 0;

void afficher(){
  for(int i = 0 ; i < taille ; i++){
  	if(i == prochain_produit)
  		printf(" ] ");
  	if(i == prochain_consomme)
  		printf(" [ ");
  	printf(" %d ",buffer[i]);
  }
  printf("\n\n");
}



int main(int argc, char** argv) {

  
  buffer = malloc(taille * sizeof(int));
  for(int i = 0 ; i <  taille ; i++){
    buffer[i] = 0;
  }
 
  free(buffer); 
  printf("Fin.\n"); 
  
  return 0;
}
