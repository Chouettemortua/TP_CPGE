#include <stdio.h>

int fact(int n){
    int res = 1;
    while (n>0){
        res = res*n;
        n = n-1;
    }
    return res;
}

void affiche_fact(int n){
    printf("%d! = %d\n", n, fact(n));
}

int main(void){
    int i = 0;
    while (i < 9)
    {
        affiche_fact(i);
        i=i+1;
    }
    return 0;
}