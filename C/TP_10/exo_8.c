#include <stdio.h>

void ligne(int n){
    int i = 0;
    while (i<n)
        {
            printf("*");
            i++;
        }
}

void fig_1(void){
    int i = 0;
    while (i<4)
    {
        ligne(6);
        printf("\n");
        i++;
    }
    printf(" \n");
    i = 1;
    while (i<=5)
    {
        ligne(i);
        printf("\n");
        i++;
    }
    printf(" \n");
    i = 6;
    while (i>0)
    {
        ligne(i);
        printf("\n");
        i--;
    }
}

void fig_2(void){
    int i = 0;
    while (i<5)
    {
        int j = 0;
        while (j<4)
        {
            if(i==0||i==4||j==0||j==3){
                printf("*");
            }
            else{
                printf(" ");
            }
            j++;
        }
       printf("\n");
       i++;
    }
    printf(" \n");
    i = 1;
    while (i<=6)
    {
        int j = 1;
        while (j<=i)
        {
            if(i==6||j==1||j==i){
                printf("*");
            }
            else{
                printf(" ");
            }
            j++;
        }
        printf(" \n");
        i++;
    }
}

void fig_3(void){
    int i = 1;
    int h = 0;
    while (i < 13)
    {   
        int j = 5-h;
        while (j>0)
        {
            printf(" ");
            j--;
        }
        ligne(i);
        printf("\n");
        i = i+2;
        h++;
    }
}

void fig_4(void){
    int i = 1;
    int h = 0;
    while (i < 13)
    {   
        int j = 5-h;
        while (j>0)
        {
            printf(" ");
            j--;
        }
        int m = 1;
        while (m<=i)
        {   
            if(i==1||m==1||m==i){
                printf("/");
            }
            if(i==11&&m!=1&&m!=i){
                printf("_");
            }
            else{
                printf(" ");
            }
            m++;
        }
        
        printf("\n");
        i = i+2;
        h++;
    }
} 


int main(void){
    fig_1();
    printf("\n");
    fig_2();
    printf("\n");
    fig_3();
    printf("\n");
    fig_4();
    return 0;
}
