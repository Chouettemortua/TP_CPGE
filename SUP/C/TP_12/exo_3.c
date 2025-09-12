#include <stdio.h>
#include <stdlib.h>

const int taille = 10;
int tab[10];

void remplire(void){
    for(int i=0;i<taille; i++){
        tab[i]= rand();
    }
}

void affiche(void){
    for (size_t i = 0; i <taille; i++)
    {
        printf("%d ",tab[i]);
    }
    printf("\n");
}

int min(void){
    int mini = tab[0];
    for(int i=1; i<taille; i++){
        if(tab[i]<mini){
            mini = tab[i];
        }
    }
    return mini;
}

int indice_min(void){
    int mini = 0;
    for(int i=1; i<taille; i++){
        if(tab[i]<tab[mini]){
            mini = i;
        }
    }
    return mini;
}

void tri_insertion(void){
    for(int i=1;i<taille;i++){
        int el = i;
        for(int j=(i-1);j>=0&&tab[el]<tab[j]; j--){
            int temp = tab[el];
            tab[el]=tab[j];
            tab[j]=temp;
            el = j;
        }
    }
}

int main(void){
    remplire();
    affiche();
    printf("min=%d\n",min());
    printf("indice_min=%d\n",indice_min());
    tri_insertion();
    affiche();
    return 0;
}