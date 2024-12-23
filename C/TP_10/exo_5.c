#include <stdio.h>

int abs(int n){
    if (n > 0){
        return n;
    }
    else{
        return -n;
    }
}

void affiche_abs(int n){
    printf("abs(%d) = %d\n", n, abs(n));
}

int test_abs(void){
    int i = -5;
    while (i <= 5)
    {
        affiche_abs(i);
        i=i+1;
    }
    return 0;
}

void affiche_si_pair(int n){
    if (n%2 == 0){
        printf("%d\n", n);
    }
}

int main(void){
    int i = 0;
    printf("Test de si pair\n");
    printf("\n");
    while (i <= 10)
    {
        affiche_si_pair(i);
        i=i+1;
    } 
    i = -5;
    printf("\n");
    printf("Test de abs\n");
    printf("\n");
    while (i <= 5)
    {
        affiche_abs(i);
        i=i+1;
    }   
    return 0;
}