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

byte_t decode_cw(FILE *fp, cw_t cw, stack *s){
    assert(cw < dict.next_available_cw);
    int size_ini = stack_size(s);
    dict_entry_t in = dict.data[cw];
    while (in.pointer != NULL_CW){
        stack_push(s, in.byte);
        in = dict.data[in.pointer];
    }
    stack_push(s, in.byte);
    while (stack_size(s)>size_ini){
        putc(stack_pop(s),fp);
    }
    
    return in.byte;
}

byte_t get_first_byte(cw_t cw){
    dict_entry_t in = dict.data[cw];
    while (in.pointer != NULL_CW){
        in = dict.data[in.pointer];
    }
    return in.byte;
}

void mock_decompress(FILE *input_file, FILE *output_file){
    stack *s = stack_new(DICTFULL);
    cw_t prev;
    cw_t current;

    if(fscanf(input_file, "%d", &prev)==1){
        decode_cw(output_file, prev, s);
    }

    while(fscanf(input_file, "%d", &current)==1){
        if(current < dict.next_available_cw){
            uint8_t byte = decode_cw(output_file, current, s);
            build_entry(prev, byte);
        }
        else{
            uint8_t byte = get_first_byte(prev);
            build_entry(prev, byte);
            decode_cw(output_file, current, s);
        }
        prev = current;
    }
    stack_free(s);   
}

void outputs_bits(bit_file *bf, uint64_t data, int width, bool flush){
    
}

int main(int argc, char* argv[]){

    FILE *input = stdin;
    FILE *output = stdout;
    if(argc >= 3){input = fopen(argv[2], "r");}
    if(argc >= 4){output = fopen(argv[3], "w");}
    if(input == NULL){
        printf("On ne peut pas ouvrir %s \n", argv[2]);
        return EXIT_FAILURE;
    }
    if(output == NULL){
        printf("On ne peut pas ouvrir %s \n", argv[3]);
        return EXIT_FAILURE;
    }

    initilize_dictionary();
    if(argv[1][0]=='c'){return EXIT_SUCCESS;}
    if(argv[1][0]=='C'){
        mock_compress(input,output);
        }
    if(argv[1][0]=='d'){return EXIT_SUCCESS;}
    if(argv[1][0]=='D'){
        mock_decompress(input, output);
    }
    
    fclose(input);
    fclose(output);
    return EXIT_SUCCESS;
}
