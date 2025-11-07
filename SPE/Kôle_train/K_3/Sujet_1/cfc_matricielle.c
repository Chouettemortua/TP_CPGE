#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

// Type de graphe orienté
// Les sommets sont des entiers de 0 à N-1
struct graphe {
  unsigned int N;
  bool** adj; // Matrice d'adjacence, représenté par un tableau 2D
};
typedef struct graphe graphe;

// Cherche si l'arête (s,t) existe
bool existe_arete(const graphe g, unsigned int s, unsigned int t) {
  return g.adj[s][t];
}

// Crée l'arête (s,t)
void modifier_arete(graphe *g, unsigned int s, unsigned int t, bool w) {
  g->adj[s][t] = w;
}

// Affichage du graphe
void afficher_graphe(const graphe g){

    // Affichage des arêtes
    for(unsigned int i = 0 ; i < g.N ; i++){
        for (unsigned int j = 0 ; j < g.N ; j++){
            if(existe_arete(g,i,j)){
                printf("%u -> %u\n",i,j);
            }
        }
    }
}

// Création d'un graphe à nb sommets, sans arête
graphe* init_graphe(unsigned int nb) {

  graphe* g = malloc(sizeof(graphe));
  g->N = nb;
  g->adj = malloc(nb * sizeof(bool*));

  // On n'a aucune arête initialement.
  for (unsigned int s = 0; s < nb; s++) {
  
    g->adj[s] = malloc(nb * sizeof(bool*));
    
    for (unsigned int t = 0; t < nb; t++) {
        modifier_arete(g,s,t,false);
    }
  }
  
  return g;
}

// Libération de la mémoire
void liberer_graphe(graphe *g) {
  for(unsigned int i = 0 ; i < g->N ; i++){
  	free(g->adj[i]);
  }
  free(g->adj);
  free(g);
}



//__________Partie I : Composantes fortement connexes : Approche matricielle__________

// Affiche la matrice de taille n x n donnée
void afficher_matrice(unsigned int n, bool** m1){
    for(unsigned int i = 0 ; i < n ; i++){
        for(unsigned int j = 0 ; j < n ; j++){
            if(m1[i][j]) printf("1 ");
            else printf("0 ");
        }
        printf("\n");
    }
    printf("\n");
}

// Question 1 : Produit matriciel booléen exemple :
// | F V | | V F |   | F F |   | V F |
// | V F | | V F | + | F V | = | V V |

// Question 2 : 
// Le neutre pour l'addition booléenne est la matrice avec tous les éléments à false.
// Le neutre pour la multiplication booléenne est la matrice des true sur la diagonale et false ailleurs.

// Question 3 : libérer une matrice booléenne de taille n x n
void liberer_matrice(bool** m, int n){
    for (int i = 0; i<n; i++){
        free(m[i]);
    }
    free(m);
}

// Question 4 : générer une matrice nulle de taille n x n
bool** nulle (unsigned int n){
    bool** m = malloc(n*sizeof(bool*));
    for (unsigned int i = 0 ; i < n ; i++){
        m[i] = malloc(n*sizeof(bool));
        for (unsigned int j = 0 ; j < n ; j++){
            m[i][j] = false;
        }
    }
    return m;
}

// Question 5 : générer la matrice identité de taille n x n
bool** identite (unsigned int n){
    bool** m = malloc(n*sizeof(bool*));
    for (unsigned int i = 0 ; i < n ; i++){
        m[i] = malloc(n*sizeof(bool));
        for (unsigned int j = 0 ; j < n ; j++){
            if (i==j) m[i][j] = true;
            else m[i][j] = false;
        }
    }
    return m;
}

// Question 6 : somme booléenne de deux matrices de taille n x n
void somme(unsigned int n, bool** m1, bool** m2, bool** m3){
    for (unsigned int i = 0 ; i < n ; i++){
        for (unsigned int j = 0 ; j < n ; j++){
            m3[i][j] = m1[i][j] || m2[i][j];
        }
    }
}

// Question 7 : produit booléen de deux matrices de taille n x n
void produit(unsigned int n, bool** m1, bool** m2, bool** m3){
    for (unsigned int i = 0 ; i < n ; i++){
        for (unsigned int j = 0 ; j < n ; j++){
            m3[i][j] = false;
            for (unsigned int k = 0 ; k < n ; k++){
                m3[i][j] = m3[i][j] || (m1[i][k] && m2[k][j]);
            }
        }
    }
}

// Question 8 : Complexité des fonctions somme et produit
// La complexité de la fonction somme est O(n^2) car elle utilise deux boucles imbriquées de taille n.
// La complexité de la fonction produit est O(n^3) car elle utilise trois boucles imbriquées de taille n.

// Question 9 : Soit B la matrice d'adjacence d'un graphe G = (S,A), Soit B^p = (m ij)i,j in S.

// Montrer que pour tout i,j in S, m ij = true ssi il existe un chemin de longueur p de i à j dans G.
// Preuve par récurrence sur p.
// Initialisation : p = 0
// Pour p = 0, m ii = true car le seul chemin de longueur 0 est le chemin vide de i à i.
// Pour i != j, m ij = false car il n'existe pas de chemin de longueur 0 de i à j.
// Hérédité : Supposons que la propriété est vraie pour p = k, montrons qu'elle est vraie pour p = k+1.
// Soit m ij = true dans B^(k+1). Par définition du produit matriciel booléen, il existe un sommet intermédiaire r tel que m ir = true dans B^k et m rj = true dans B.
// Par hypothèse de récurrence, il existe un chemin de longueur k de i à r dans G et une arête de r à j dans G.
// En concaténant ces deux chemins, on obtient un chemin de longueur k+1 de i à j dans G.
// Réciproquement, si il existe un chemin de longueur k+1 de i à j dans G, alors il existe un sommet intermédiaire r tel que il existe un chemin de longueur k de i à r dans G et une arête de r à j dans G.
// Par hypothèse de récurrence, m ir = true dans B^k et m rj = true dans B.
// Donc m ij = true dans B^(k+1).
// Conclusion : Par le principe de récurrence, la propriété est vraie pour tout p >= 1.

// Question 10 : On pose B_p = B^0 + B^1 + ... + B^p. On note B_p = (q ij)i,j in S.

// Montrer que pour tout i,j in S, q ij = true ssi il existe un chemin de longueur au plus p de i à j dans G.
// Preuve par récurrence sur p.
// Initialisation : p = 0
// Pour p = 0, q ij = true ssi i = j, ce qui est vrai par définition de la matrice identité. (B^0 = I)
// Hérédité : Supposons que la propriété est vraie pour p = k, montrons qu'elle est vraie pour p = k+1.
// Soit q ij = true dans B^(k+1). Par définition de la somme booléenne, q ij = true ssi m ij = true dans B^(k+1) ou q ij = true dans B^k.
// Si m ij = true dans B^(k+1), alors par la question 9, il existe un chemin de longueur k+1 de i à j dans G.
// Sinon, si q ij = true dans B^k, alors par hypothèse de récurrence, il existe un chemin de longueur au plus k de i à j dans G.
// Dans les deux cas, il existe un chemin de longueur au plus k+1 de i à j dans G.
// Réciproquement, si il existe un chemin de longueur au plus k+1 de i à j dans G, alors soit ce chemin est de longueur k+1, soit il est de longueur au plus k.
// Si le chemin est de longueur k+1, alors par la question 9, m ij = true dans B^(k+1).
// Sinon, si le chemin est de longueur au plus k, alors par hypothèse de récurrence, q ij = true dans B^k. 
// Donc q ij = true dans B^(k+1).
// Conclusion : Par le principe de récurrence, la propriété est vraie pour tout p >= 0.

// Question 11 : montrer que (B_p)p in N est une suite stationnaire et admet un limite B*.

// La suite (B_p)p in N est une suite croissante pour l'ordre partiel défini par la relation "être un sous-ensemble".
// En effet, pour tout p >= 0, B_p+1 = B_p + B^(p+1) >= B_p.
// De plus, la suite est bornée supérieurement par la matrice de taille n x n avec tous les éléments à true.
// En effet, pour tout p >= 0, B_p <= J, où J est la matrice avec tous les éléments à true.
// Par le théorème de la convergence monotone, la suite (B_p)p in N converge vers une limite B*.
// De plus, comme la suite est croissante et bornée supérieurement, elle est stationnaire à partir d'un certain rang p0.
// Autrement dit, il existe un entier P tel que pour tout p >= P, B_p = B*.
// dans le pire cas P = n-1 car le plus long chemin dans un graphe sans cycle a une longueur de n-1.

// Question 12 : Écrire une fonction qui calcule la matrice d'accessibilité d'un graphe g donné.

// Relation de récurrence de la suite (B_p)p in N :
// B_0 = I
// B_p+1 = B_p + B^p+1 = I + B^1 + B^2 + ... + B^p + B^(p+1) = I + B*(B_p)
bool** chemins(const graphe g){
  unsigned int n = g.N;
  bool** B_p = identite(n);  // B_0 = I
  bool** B_temp = nulle(n); // temporaire pour le calcul de B^p
  // Calcul de B_p jusqu'à la convergence
  bool not_converged = true;
  while (not_converged){
    not_converged = false;
    for (unsigned int i = 0 ; i < n ; i++){
      for (unsigned int j = 0 ; j < n ; j++){
        B_temp[i][j] = false;
        for( unsigned int k = 0 ; k < n ; k++){
          B_temp[i][j] = B_temp[i][j] || (g.adj[i][k] && B_p[k][j]);
        }
        if(i == j){
          B_temp[i][j] = B_temp[i][j] || true;
        }
        if (B_temp[i][j] != B_p[i][j]){
          not_converged = true;
          B_p[i][j] = B_temp[i][j];
        }
      }
    }
  }
  liberer_matrice(B_temp, n);
  return B_p;
}
    
// Question 13 : Complexité de la fonction chemins
// dans le pire des cas, la fonction chemins effectue O(n-1) itérations de la boucle while avant de converger.
// À chaque itération, elle effectue O(n^3) opérations pour calculer le produit matriciel booléen.
// Ainsi, la complexité totale de la fonction chemins est O(n^4). (on doit pouvoir affiner car dans le pire cas on ne fait pas exactement n^2 itérations)

// Question 14 : Ecrire la fonction cnf qui renvoi un tab de taille |S| tel que tab[i] contient l'indice de la composante fortement connexe du sommet i.
unsigned int* cnf (const graphe g){
  unsigned int n = g.N;
  bool** accessibilite = chemins(g);
  unsigned int* composantes = malloc(n * sizeof(unsigned int));
  bool* marque = malloc(n * sizeof(bool));
  for (unsigned int i = 0 ; i < n ; i++){
    marque[i] = false;
  }
  unsigned int num_composante = 0;
  for (unsigned int i = 0 ; i < n ; i++){
    if (!marque[i]){
      for (unsigned int j = 0 ; j < n ; j++){
        if (accessibilite[i][j] && accessibilite[j][i]){
          composantes[j] = num_composante;
          marque[j] = true;
        }
      }
      num_composante++;
    }
  }
  liberer_matrice(accessibilite, n);
  free(marque);
  return composantes;
}

void afficher_composantes(unsigned int* tab, unsigned int n){
  printf("Composantes fortement connexes :\n");
  for (unsigned int i = 0 ; i < n ; i++){
    printf("Sommet %u : Composante %u\n", i, tab[i]);
  }
  printf("\n");
}

//__________Main__________
int main(int argc, char** argv) {
  graphe* g_0 = init_graphe(8);
  modifier_arete(g_0,0,4,true);
  modifier_arete(g_0,1,0,true);
  modifier_arete(g_0,4,1,true);
  modifier_arete(g_0,5,1,true);
  modifier_arete(g_0,5,4,true);
  modifier_arete(g_0,5,6,true);
  modifier_arete(g_0,2,1,true);
  modifier_arete(g_0,2,3,true);
  modifier_arete(g_0,6,5,true);
  modifier_arete(g_0,6,2,true);
  modifier_arete(g_0,5,1,true);
  modifier_arete(g_0,7,6,true);  
  modifier_arete(g_0,7,3,true);
  modifier_arete(g_0,3,2,true);
  bool** m = chemins(*g_0);
  unsigned int* tab = cnf(*g_0);
  afficher_matrice(g_0->N, m);
  afficher_composantes(tab, g_0->N);
  free(tab);
  liberer_matrice(m, g_0->N);
  liberer_graphe(g_0); 
  return 0;
}
