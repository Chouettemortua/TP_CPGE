#include <stdio.h>

int boucle(int n){
    int i = 0;
    while ( i < n){
        if (i%2 == 0)
        {
            printf("%d\n", i);
        }  
        i++;
    }
    /*i = 0;
    while (i<n)
    {
        if (i%2 == 1)
        {
            printf("%d\n", i);
            i++;
        }
        else{
            i = i*2;
        }
    }*/
    i = 0;
    while (n != 0)
    {
        i++;
        n = n/2;
    }
}

int main(void){
    int i = 1;
    while (i <= 5)
    {
        boucle(i);
        i++;
    }
}