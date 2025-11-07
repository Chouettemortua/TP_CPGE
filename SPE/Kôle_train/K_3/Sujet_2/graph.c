#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

struct graph_s {
  // Nombre de sommets
  int n;
  // Degré de chaque somment
  int degre[100];
  // Listes d'adjacences (tableau de tableaux)
  int voisins[100][10];
};

typedef struct graph_s graph;

int degre_max(graph* g, bool* partie) {
  // À compléter
  return -1;
}

bool* accessibles(graph* g, int s) {
  // À compléter
  return NULL;
}

int nb_accessibles(graph* g, int s) {
  int res = 0;
  bool* vu = accessibles(g, s);
  if (vu == NULL) {return -1;}
  for (int i = 0; i < g->n; i += 1) {
    if (vu[i]) {
      res += 1;
    }
  }
  free(vu);
  return res;
}

int degre_etoile(graph* g, int s) {
  // À compléter
  return -1;
}

int main(void) {

  graph g_exemple = {
    .n = 9,
    .degre = {0, 2, 1, 2, 2, 3, 1, 1, 0},
    .voisins = {
    /* 0 */ {-1}, // Degré 0 : valeur ignorée
    /* 1 */ {0, 4},
    /* 2 */ {4},
    /* 3 */ {0, 4},
    /* 4 */ {6, 7},
    /* 5 */ {2, 4, 8},
    /* 6 */ {7},
    /* 7 */ {8},
    /* 8 */ {-1} // Degré 0 : valeur ignorée
    }
  };

  bool pairs[9] = {true, false, true, false, true, false, true, false, true};

  graph* g = &g_exemple;

  printf("Le degré maximal d'un sommet pair de g est : %d\n\n", degre_max(g, pairs));

  for (int s = 0; s < g->n; s += 1) {
    printf("Sommet %d : %d sommet(s) accessible(s)\n", s, nb_accessibles(g, s));
  }

  printf("\n");

  for (int s = 0; s < g->n; s += 1) {
    printf("d*(%d) = %d\n", s, degre_etoile(g, s));
  }

}
