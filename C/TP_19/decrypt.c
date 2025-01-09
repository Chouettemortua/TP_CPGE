#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>

char decrypt(char c_in, int k){
    return (char)((int)c_in -k%256);
}

int decrypt_file(const char* filename_in, const char* filename_out, int k) {
    FILE* fp_in = fopen(filename_in, "r");
    if(fp_in == NULL) { // si f = NULL, il y a eu une erreur
        fprintf(stderr, "Le fichier \"%s\" n'a pas pu être ouvert.", filename_in);
        return EXIT_FAILURE;
    }
    FILE* fp_out = fopen(filename_out, "w");
    if(fp_out == NULL) {
        fprintf(stderr, "Le fichier \"%s\" n'a pas pu être ouvert.", filename_out);
        return EXIT_FAILURE;
    }

    char c_in;
    char c_decrypted;
    int code_retour_lecture;
    int code_retour_ecriture;
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

        c_decrypted = decrypt(c_in, k);
        code_retour_ecriture = fprintf(fp_out, "%c", c_decrypted);

        if (code_retour_ecriture == EOF) {
            return EXIT_FAILURE;
        }
    }
    if (fclose(fp_in) == EOF) {return EXIT_FAILURE;}
    if (fclose(fp_out) == EOF) {return EXIT_FAILURE;}
    return EXIT_SUCCESS;
}

int main(int argc, char* argv[]) {
    assert (argc >= 4);
    decrypt_file(argv[1],argv[2],atoi(argv[3]));
    return 0;
}