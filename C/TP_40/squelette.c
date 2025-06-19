//
// Squelette du TP40 sur le codage de LZW
//

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include "bitpacking.h"
#include "stack.h"

typedef uint32_t cw_t;
typedef uint8_t byte_t;

#define CW_MAX_WIDTH 16
#define DICTFULL (1u << CW_MAX_WIDTH)

const cw_t NO_ENTRY = DICTFULL;
const cw_t NULL_CW = DICTFULL;
const cw_t FIRST_CW = 0x100;
const int CW_MIN_WIDTH = 9;

int VERBOSITY = 0;

struct dict_entry_t {
    cw_t pointer;
    uint8_t byte;
};

typedef struct dict_entry_t dict_entry_t;

struct dict_t {
    cw_t next_available_cw;
    int cw_width;
    dict_entry_t data[DICTFULL];
};

struct dict_t dict;

cw_t inverse_table[DICTFULL][256];

void initilize_dictionary(void){

    dict.next_available_cw = FIRST_CW;
    dict.cw_width = CW_MIN_WIDTH;
    for(cw_t i = 0; i < FIRST_CW; i++){
        dict.data[i].pointer = NULL_CW;;
        dict.data[i].byte = i;
    }
};

cw_t look_up(cw_t cw, byte_t byte){
    cw_t res = inverse_table[cw][byte];
    if(res >= dict.next_available_cw){return NO_ENTRY;}
    if(cw == dict.data[res].pointer && byte == dict.data[res].byte){return res;}
    return NO_ENTRY;
};

void build_entry(cw_t cw, byte_t byte){
    cw_t suivant = dict.next_available_cw;
    if(suivant != DICTFULL){
        dict.data[suivant].pointer = cw;
        dict.data[suivant].byte = byte;
        inverse_table[cw][byte] = suivant;
        dict.next_available_cw += 1;
    }
}

void mock_compress(FILE *input_file, FILE *output_file){
    cw_t current = NULL_CW;
    int out = getc(input_file);
    while(out!=EOF){
        if(current == NULL_CW){current = out;}
        else{
            cw_t save = look_up(current, (byte_t)out);
            if(save == NO_ENTRY){
                fprintf(output_file, "%d ", current);
                build_entry(current, (byte_t)out);
                current = (cw_t)out;
            }
            else{current = save;}
        }
        out = getc(input_file);   
    }
    fprintf(output_file, "%d", current);
}

int main(int argc, char* argv[]){

    FILE *input = stdin;
    FILE *output = stdout;
    if(argc >= 3){input = fopen(argv[2], "rb");}
    if(argc >= 4){output = fopen(argv[3], "wb");}
    if(input = NULL){
        printf("On ne peut pas ouvrir %s \n", argv[2]);
        return EXIT_FAILURE;
    }
    if(output = NULL){
        printf("On ne peut pas ouvrir %s \n", argv[3]);
        return EXIT_FAILURE;
    }



    if(argv[1]='c'){return EXIT_SUCCESS;}
    if(argv[1]='C'){EXIT_SUCCESS;}
    if(argv[1]='d'){return EXIT_SUCCESS;}
    if(argv[1]='D'){return EXIT_SUCCESS;}
    return EXIT_SUCCESS;
}
