//
// TP 13
// Squelette à remplir
//
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <math.h>

/* Exercice XIII.1 */
typedef int rgb[3]; // rgb est le *type* "tableau de trois int"

rgb red   = {255, 0, 0};
rgb green = {0, 255, 0};
rgb blue  = {0, 0, 255};
rgb black = {0, 0, 0};
rgb gray = {127, 127, 127};
rgb white = {255, 255, 255};

// #define HEIGHT 600
#define HEIGHT 400
// #define WIDTH  800
#define WIDTH  600
rgb canvas[HEIGHT][WIDTH];

// Ajoute un pixel en coordonnées `x,y` et de couleur `c`
void put_pixel(int x, int y, rgb c){
    int i = y;
    int j = x;
    if (i < 0 || i > HEIGHT || j < 0 || j > WIDTH) {
        // affiche un Warning comme un commentaire
        printf("# put_pixel(x=%i,y=%i,c=(%i,%i,%i)) with coordinates exterior to the canvas, not drawing.\n", x, y, c[0], c[1], c[2]);
    } else {
        for (int k = 0; k < 3; k++){
            canvas[i][j][k] = c[k];
        }
    }
}


// Affiche le canvas sur le stdout
void print_canvas(void){
    printf("P3\n");
    printf("%d %d\n", WIDTH, HEIGHT);
    printf("255\n");
    for (int i = 0; i < HEIGHT; i++){
        for (int j = 0; j < WIDTH; j++){
            for (int k = 0; k < 3; k++){
                printf("%d ", canvas[i][j][k]);
            }
            printf("\n");
        }
    }
}

void draw_h_ligne(int y, int x0, int x1, rgb c){
    int i = x0;
    int j = x1;
    if (y<0||y>HEIGHT||i>WIDTH||j>WIDTH||i<0||j<0)
    {
        // affiche un Warning comme un commentaire
        printf("# draw_h_ligne(x0=%i,x1=%i,y=%i,c=(%i,%i,%i)) with coordinates exterior to the canvas, not drawing.\n", x0, x1, y, c[0], c[1], c[2]);
    }
    else{
        if(i<=j){
            for(int k = i; k<=j;k++){
                put_pixel(k,y,c);
            }
        }
        else{
            for(int k = j; k<=i;k++){
                put_pixel(k,y,c);
            }
        }
    }
}

void draw_v_ligne(int x, int y0,int y1, rgb c){
    if (x<0||y0<0||y1<0||y0>HEIGHT||y1>HEIGHT)
    {
        // affiche un Warning comme un commentaire
        printf("# draw_h_ligne(x=%i,y0=%i,y1=%i,c=(%i,%i,%i)) with coordinates exterior to the canvas, not drawing.\n", x, y0, y1, c[0], c[1], c[2]);
    }
    else{
        if(y0<y1){
            for(int k = y0; k<=y1; k++){
                put_pixel(x,k,c);
            }
        }
        else{
            for(int k = y1; k<=y0; k++){
                put_pixel(x,k,c);
            }
        }
    }

}

void fill_rectangle(int x0, int x1,int y0,int y1,rgb c){
    if(x0>x1){
        int temp = x0;
        x0 = x1;
        x1 = temp;
    }
    if(y0>y1){
        int temp = y0;
        y0 = y1;
        y1 = temp;
    }
    for(int i=y0; i<y1;i++){
        draw_h_ligne(i,x0,x1,c);
    }
}

void fill_disk(int xc, int yc, int radius, rgb c){
    for(int i=yc-radius; i<=yc+radius;i++){
        for(int j = xc-radius; j<=xc+radius;j++){
            if((i-yc)*(i-yc)+(j-xc)*(j-xc)<=radius*radius){
                put_pixel(j,i,c);
            }
        }
    }
}

int clamp(double x){
    if(x<=0){return 0;}
    if(x>=255){return 255;}
    else{return x;}
}

void mix(rgb c0, rgb c1, double alpha, double beta, rgb result){
    for(int i=0;i<3;i++){
        result[i] = clamp(alpha*c0[i]+beta*c1[i]);
    }
}

void draw_h_gradient(int y, int x0, int x1, rgb c0, rgb c1){
    if(x0>x1){
        int temp = x0;
        x0 = x1;
        x1 = temp;
    }
    rgb coul = {0,0,0};
    for(int i=x0; i<=x1; i++){
        mix(c0,c1,(i-x0)/(x1-x0),(x1-i)/(x1-x0),coul);
        put_pixel(i,y,coul);
    }
}

// Fonction main qui est exécutée lors de l'appel au binaire
int main() {
    // Exercice XIII.1
    // printf("# Exercice XIII.1 :\n");
    for (int i = 0; i < WIDTH; i++)
    {
        for (int j = 0; j < HEIGHT; j++)
        {
            put_pixel(i,j,red);
        }
    }
    draw_h_gradient(200,50,300,green,blue);
    print_canvas();
}
