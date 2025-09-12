#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>

char encrypt(char c_in, int k){
    return (char)((int)c_in +k%256);
}

int encrypt_file(const char* filename_in, int k) {
    FILE* fp_in = fopen(filename_in, "r");
    if(fp_in == NULL) { // si f = NULL, il y a eu une erreur
        fprintf(stderr, "Le fichier \"%s\" n'a pas pu être ouvert.", filename_in);
        return EXIT_FAILURE;
    }

    char c_in;
    char c_encrypted;
    int code_retour_lecture;
    while (true) {
        code_retour_lecture = fscanf(fp_in, "%c", &c_in);
        // lit un caractère stockés dans c_in
        // à compléter, pour encoder le char c_in en c_encrypted, et écrire c_encrypted

        if (code_retour_lecture == EOF) {
            if (feof(fp_in)) { // fin du fichier, erreur normale
                return EXIT_SUCCESS;
            } else {
                return EXIT_FAILURE; // autre erreur
            }
        }

        c_encrypted = encrypt(c_in, k);
        printf("%c", c_encrypted);
    }
    if (fclose(fp_in) == EOF) {return EXIT_FAILURE;}
    return EXIT_SUCCESS;
}

int main(int argc, char* argv[]) {
    assert (argc >= 3);
    encrypt_file(argv[1],atoi(argv[2]));
    return 0;
}