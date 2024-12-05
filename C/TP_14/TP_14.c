#include <stdio.h>
#include <stdbool.h>

void extrema(int t[], int taille, int *min, int *max){
    *min = t[0];
    *max = t[0];
    for(int i=1;i<taille;i++){
        if(*min>t[i]){
            *min=t[i];
        }
        if(*max<t[i]){
            *max=t[i];
        }
    }
}

void exo_6(void){
    int n;
    int p;
    float f;
    scanf("%d %d",&n, &p);
    for(int i=0;i<n;i++){
        float res = 0.;
        for(int j=0;j<p;j++){
            scanf("%f",&f);
            res = res + f;
        }
        printf("%f\n",res);
    }
}

int main(void){
    //test premierre fonc

    //int tab[5] = {0,80,-1,3,4};
    //int taille = 5;
    //int min;
    //int max;
    //extrema(tab,taille,&min,&max);
    //printf("min=%d, max=%d\n",min,max);

    //test nd fonc

    //exo_6();

}