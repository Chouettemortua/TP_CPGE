#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int plus_frequent_sucesseur(char c, char* s) {
    int count[256] = {0};
    for(int i = 0; s[i]!='\0'; i++) {
        if(s[i] == c && s[i+1] != '\0') {
            count[(int)(s[i+1])]++;
        }
    }
    int max_count = 0;
    int most_frequent = 0;
    for(int i = 0; i < 256; i++) {
        if(count[i] > max_count) {
            max_count = count[i];
            most_frequent = (int)i;
        }
    }
    return most_frequent;
}

/*Cette Fonction a une complexiter temporelle de O(K*n); K le nombre de caractère et n la longeur de la chaine
Pour améliorer le tout on pourais en un passage calculer les successeur les plus fréquent de chaque lettre*/
int* init_modele(char* chaine){
    int* m = (int*)malloc(256 * sizeof(int));
    for(int i = 0; i < 256; i++) {
        m[i] = 0;
        m[(int)i] = plus_frequent_sucesseur(i, chaine);
    }
    return m;
}

int** matrice_confusion(int* M, char* test){
    int** mat = (int**)malloc(256 * sizeof(int*));
    for(int i = 0; i < 256; i++) {
        mat[i] = (int*)malloc(256 * sizeof(int));
        for(int j = 0; j < 256; j++) {
            mat[i][j] = 0;
        }
    }
    for(int i = 0; test[i] != '\0'; i++) {
        char c = test[i];
        char next = test[i+1];
        //printf("Le successeur le plus fréquent de '%c' est '%c' alors que sont vrais suivant est '%c'\n", c, (char)M[c], next);
        if(next != '\0') {
            mat[(int)next][(int)M[c]]++;
        }
    }
    return mat;
}

void free_mat(int** mat) {
    for(int i = 0; i < 256; i++) {
        free(mat[i]);
    }
    free(mat);
}

void print_matrice(int** mat) {
    printf("Matrice de confusion :\n");
    for(int i = 0; i < 256; i++) {
        int f = 0;
        for(int j = 0; j < 256; j++) {
            if(i == j && mat[i][j] > 0) {
                printf("%c est prédit correctement %d fois\n", (char)i, mat[i][j]);
            }
            else
                f += mat[i][j];
        }
        if (f > 0){
            printf("%c est prédit incorrectement %d fois\n", (char)i, f);
        }
    }
}

float pourcentage_erreur(int** mat) {
    int correct = 0;
    int total = 0;
    for(int i = 0; i < 256; i++) {
        for(int j = 0; j < 256; j++) {
            if(i == j) {
                correct += mat[i][j];
            }
            total += mat[i][j];
        }
    }
    if (total == 0) return 0.0;
    return (double)(total - correct) / (double)total * 100.0;
}

int main() {
    char* s = "Bonjour, comment allez-vous ? Ca va, ca va aller bien mieux";
    int* modele = init_modele(s);
    char* test = "Bonjour, ca va bien ? Oui ! Bien mieux, et vous, ca va ?";
    int** mat = matrice_confusion(modele, test);
    //print_matrice(mat);
    printf("Pourcentage d'erreur : %.2f%%\n", pourcentage_erreur(mat));
    free_mat(mat);
    free(modele);
    return 0;
}