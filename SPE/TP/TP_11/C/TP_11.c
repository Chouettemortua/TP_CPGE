#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <pthread.h>

int borne = 20;
long unsigned int compteur = 0;
long unsigned int objectif;
pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;

void f(char* m){
    for(int i = 0; i < borne; i++){
        printf("%s%d ", m, i);
    }
    printf("\n");
}

void part1(){
    pthread_t t1;
    pthread_t t2;
    pthread_create(&t1, NULL, (void*)f, "A");
    pthread_create(&t2, NULL, (void*)f, "B");
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    printf("Fini\n");
}

long unsigned int puissance(long unsigned int a, long unsigned int b){
    if (b == 0) return 1;
    return a*puissance(a, b - 1);
}

void* f2(void* arg){
    for(unsigned long int i = 0; i < objectif; i++){
        compteur++;
    }
}

void part2(){
    objectif = puissance(2, 30);
    printf("2^30 = %lu\n", objectif);
    f2(NULL);
    f2(NULL);
    f2(NULL);
    f2(NULL);
    printf("Compteur = %lu\n", compteur);
}

void* f3(void* arg){
    for(unsigned long int i = 0; i < objectif; i++){
        pthread_mutex_lock(&m);
        compteur++;
        pthread_mutex_unlock(&m);
    }
    pthread_exit(NULL);
}

void* g(void* arg){
    unsigned long int local = 0;
    for(unsigned long int i = 0; i < objectif; i++){
        local++;
    }
    pthread_mutex_lock(&m);
    compteur += local;
    pthread_mutex_unlock(&m);
    pthread_exit(NULL);
}

int main(int argc, char* argv[]){
    //part1();
    //part2();
    objectif = puissance(2, 30);
    printf("Objectif: %lu\n", objectif);
    pthread_t* threads = malloc(4 * sizeof(pthread_t));
    for (int i = 0; i < 4; i++) {
        pthread_create(&threads[i], NULL, g, NULL);
    }
    for (int i = 0; i < 4; i++) {
        pthread_join(threads[i], NULL);
    }
    printf("Compteur = %lu\n", compteur);
    free(threads);
    return 0;
}
