#include <stdio.h>
#include <stdlib.h>

double expo(double x, int n){
    if(n==0){return 1;}
    if(n%2==0){
        return expo(x*x, n/2);
    }
    else return x*expo(x,(n-1));
}

int main(int argc, char* argv[]){
    if(argc!=3){
        printf("Il faut donner un entier et un flottant\n");
        return 1;
    }
    int n = atoi(argv[1]);
    double x = atof(argv[2]);
    printf("x^n = %f\n", expo(x,n));
    return 0;
}