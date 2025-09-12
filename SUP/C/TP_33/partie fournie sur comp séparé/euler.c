//
// Squelette TP 33
// Graphes eulériens et compilation séparée
//

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

#include "stack.h"
#include "graph.h"

// Lecture de données depuis l'entrée standard
// Vous voyez dans le Makefile que le binaire euler.exe est appelé avec
// cat g3.txt | ./euler.exe
int *read_data(int *nb_vertex, int *nb_edges){
    scanf("%d %d", nb_vertex, nb_edges);
    int* edges = malloc(sizeof(int)*2*(*nb_edges));
    for(int i=0; i<*nb_edges; i++){
        int a, b = scanf("%d %d", &a, &b);
        edges[2*i] = a;
        edges[2*i+1] = b;
    }
    return edges;
}

// Implémentation de l'algorithme de Hierholzer
// avec deux piles nommées euler et current
stack *euler_tour(graph g){
    stack* actuel = stack_new(g.nb_edges);
    stack* euler = stack_new(g.nb_edges);

}

// Fonction main
int main(void){
    // Lit les data avec read_data(&nb_vertex, &nb_edges)
    // depuis l'entrée standard
    int nb_vertex;
    int nb_edges;
    int * edges = read_data(&nb_vertex, &nb_vertex);

    // puis construit un graph g avec build_graph(...)
    graph g = build_graph(edges, nb_vertex, nb_edges);

    // enfin, construit la pile stack *tour avec euler_tour(g);

    // il faut l'afficher sur la sortie standard, dans le bon ordre

    return 0;
}
