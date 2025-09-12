#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>

typedef u_int32_t ui;

const int BLOCK_SIZE = 4;
const int RADIX =1<<BLOCK_SIZE;
const int MASK = RADIX-1;

void copy(ui *out, ui *in, int len){
    for(int i=0; i<len; i++){
        out[i] = in[i];
    }
}

void zero_out(int *arr, int len){
    for(int i=0; i<len; i++){
        arr[i] = 0;
    }
}

ui extract_digit(ui n, int k){
    return (n>>(k*BLOCK_SIZE))&MASK;
}

int* histogram(ui *arr,int len, int k){
    int *hist[RADIX];
    for(int i=0; i<RADIX; i++){
        for(int j=0; j<len; j++){
            if(i == extract_digit(arr[j],k)){
                hist[i]++;
            }
        }
    }
    return hist;
}

int main(void){
    ui arr[] = {1,2,5,4,47};
    histogram(&arr, 5, 4);
    for(int i=0; i<RADIX; i++){
        printf("%d ", arr[i]);
    }
    printf("\n");
}