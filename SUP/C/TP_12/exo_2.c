#include <stdio.h>

int plus_petit_k_f(int n){
    int count = 0;
    for(int k=1;k<n;k=k*2){
        count++;
    }
    return count;
}

int plus_petit_k_w(int n){
    int count = 0;
    int k = 1;
    while (k<n)
    {
        count++;
        k=k*2;
    }
    return count;
}

int main(void){
    for(int i=1; i<=8; i=i*2){
        printf("ff(%d) = %d\n",i, plus_petit_k_f(i));
        printf("fw(%d)=%d\n",i, plus_petit_k_w(i));
    }
    return 0;
}