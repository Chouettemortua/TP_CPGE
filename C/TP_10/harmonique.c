#include <stdio.h>

int harmo(double n){

    if (n == 0){
        return 0;
        }
    int i = 1;
    double h = 0;
    while (h< n)
    {
        h = h + 1.0/i;
        i++;
    }
    return i-1;
}

void affiche_harmo(double n){
    printf("f(%f) = %d\n", n, harmo(n));
}

int main(void){
    double i = 0;
    while (i <= 15 )
    {
        affiche_harmo(i);
        i=i+0.5;
    }
    return 0;
}