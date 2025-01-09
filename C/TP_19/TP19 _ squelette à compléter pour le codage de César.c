//
// Squelette TP19_codage_cesar.c TP 19 du 21/12/2024
// Les TODO: sont à remplir vous-même !
//
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>

// encrypte le char s_in et le renvoie
// en utilisant le codage de César d'un décalage de +k (modulo 256)
char encrypt(char c_in, int k) {
    return TODO;  // ici c'est à remplir
}

int encrypt_file(const char* filename_in, const char* filename_out, int k) {
    FILE* fp_in = fopen(filename_in, "r");
    if(fp_in == NULL) { // si f = NULL, il y a eu une erreur
        fprintf(stderr, "Le fichier \"%s\" n'a pas pu être ouvert.", filename_in);
        return EXIT_FAILURE;
    }
    FILE* fp_out = fopen(filename_out, "w");
    if(fp_out == NULL) { TODO: }

    char c_in;
    char c_encrypted;
    int code_retour_lecture;
    int code_retour_ecriture;
    while (true) {
        code_retour_lecture = fscanf(fp_in, "%c", &c_in);
        // lit un caractère stockés dans c_in
        // à compléter, pour encoder le char c_in en c_encrypted, et écrire c_encrypted
        TODO:

        if (code_retour_lecture == EOF) {
            if (feof(fp_in)) { // fin du fichier, erreur normale
                return EXIT_SUCCESS;
            } else {
                return EXIT_FAILURE; // autre erreur
            }
        }

        if (code_retour_ecriture == EOF) {
            TODO:
        }
    }
    if (fclose(fp_in) == EOF) { TODO: }
    if (fclose(fp_out) == EOF) { TODO: }
    return EXIT_SUCCESS;
}

int main(int argc, char* argv[]) {
    assert (argc >= 4);
    return TODO:;
}