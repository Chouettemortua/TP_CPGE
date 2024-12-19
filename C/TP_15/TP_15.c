#include <stdio.h>
#include <stdlib.h>

void increment(int *p){
    *p = *p+1;
}

void f(int *px,int *py){
    if(*py<*px){increment(py);}
    else{increment(px);}
}

int main(void){
    int i = 2;
    increment(&i);
    printf("%d\n", i);
}