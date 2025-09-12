#include <stdio.h>

void print_each(int argc, char* array_of_char[]){
    for(int i = 1; i<(argc-1); i++){
        printf("%s ",array_of_char[i]);
    }
    printf("%s\n",array_of_char[argc-1]);
}

int main(int argc, char* argv[]){
    print_each(argc, argv);
    printf(" \n");
}