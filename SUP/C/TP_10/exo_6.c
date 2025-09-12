#include <stdio.h>
#include <stdbool.h>


bool est_premier(int n){
    if (n < 2){
        return false;
    }
    int i = 2;
    while (i<n)
    {
        if (n%i==0)
        {
            return false;
        }
        i = i+1;
    }
    return true;
}

void affichage_est_premier(int n){
    if (est_premier(n))
    {
        printf("%d est premier\n", n);
    }
    else{
    printf("%d n'est pas premier\n", n);
    }
}

int main(void){
    int i = 0;
    printf("Test de si est premier\n");
    printf("\n");
    while (i <= 20)
    {
        affichage_est_premier(i);
        i=i+1;
    } 
}