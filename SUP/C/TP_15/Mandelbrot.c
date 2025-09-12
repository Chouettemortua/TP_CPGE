#include <stdio.h>
#include <stdlib.h>

int divergence(double xc, double yc, int itermax){
    double xz = 0;
    double yz = 0;
    int n = 0;
    while(xz*xz+yz*yz<=4 && n<=itermax){
        double temp = xz;
        xz = ((xz*xz)-(yz*yz)) + xc;
        yz = (2*yz*temp)+yc;
        n++;
    }
    return n;
}

#define ROWS 800
#define COLS 800

int arr[ROWS][COLS];


double re(int j, double xmin,double xmax){
    // quand j = 0 : on veut xmin,
    // quand j = COLS-1 : on veut xmax
    return xmin+j*((xmax-xmin)/(COLS-1));
}

double im(int i, double ymin, double ymax){
    //quand i = 0 : on veut ymax
    //quand i = ROWS-1: on veut ymin
    return ymax+i*((ymin-ymax)/(ROWS-1));
}

void fill_tab(double xmin, double xmax, double ymin,double ymax, int itermax){
    for(int i=0; i<ROWS; i++){
        for(int j=0; j<COLS; j++){
            arr[i][j] = divergence(re(j, xmin, xmax),im(i, ymin, ymax), itermax);
        }
    }
}

void print_pixel_bw(int i, int j, int itermax){
    if(arr[i][j]<=itermax){
        printf("255 255 255\n");
    }
    else{printf("0 0 0\n");}
}

void print_tab(int itermax){
    printf("P3\n");
    printf("%d %d\n",ROWS,COLS);
    printf("255\n");
    for(int i=0; i<ROWS; i++){
        for(int j=0; j<COLS; j++){
            print_pixel_bw(i,j,itermax);
        }
    }
}

int main(void){
    double xmin = -2;
    double ymin = -2;
    double xmax = 2;
    double ymax = 2;
    double itermax = 20;
    fill_tab(xmin,xmax,ymin,ymax,itermax);
    print_tab(itermax);
}    