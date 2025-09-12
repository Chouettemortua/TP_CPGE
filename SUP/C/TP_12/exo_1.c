#include <stdio.h>

int S1(int n){
    int res = 0;
    for(int k = 1; k<=n; k++){
        res = res + 2*k + 1;
    }
    return res;
}

double S2(int n){
    double res = 0;
    for(int k=1; k<=n; k++){
        res = res + 1.0/(k*k);
    }
    return res;
}

int S3(int n){
    int res = 0;
    for(int i=1; i<=n; i++){
        for(int j=1; j<=n; j++){
            res = res+i+j;
        }
    }
    return res;
}

int S4(int n){
    int res = 0;
    for(int i=1; i<=n; i++){
        for(int j=i; j<=n; j++){
            res = res+i+j;
        }
    }
    return res;
}

int S5(int n){
    int res = 0;
    for(int i=1; i<=n; i++){
        for(int j=1; j<=(i-1); j++){
            res = res+i+j;
        }
    }
    return res;
}

int main(void){
    for(int i=0;i<=3;i++){
        printf("S1(%d)=%d\n",i, S1(i));
        printf("S2(%d)=%f\n",i, S2(i));
        printf("S3(%d)=%d\n",i, S3(i));
        printf("S4(%d)=%d\n",i, S4(i));
        printf("S5(%d)=%d\n",i, S5(i));
    }
    return 0;
}
