#include <stdio.h>

int main(void){
    int n = 0;
    float x =0.;
    int p = 0;
    scanf("%d", &n);
    for(int i=0; i<n;i++){
        scanf("%d %f", &p, &x);
        printf("%f\n", p+x);
    }
    return 0;
}