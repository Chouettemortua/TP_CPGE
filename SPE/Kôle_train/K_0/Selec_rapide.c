// Slection rapide du k-ieme plus petit élment d'un tableau non trié

// Principe du tri rapide: on choisit un pivot, on partitionne le tableau
// en deux sous-tableaux, l'un avec les élments plus petits que le pivot,
// l'autre avec les plus grands. On sait alors la position du pivot dans
// le tableau trié. On recommence dans les sous-tableaux jusqu' ce
// tout soit trié et on fuse.

// Complexité : meilleur cas O(n log n), pire cas O(n^2)


#include <stdio.h>
#include <stdlib.h>

int* tri_rapide(int *t, int n){
    if (n <= 1) return t;
    int pivot = t[0];
    int *g = malloc(n * sizeof(int));
    int *d = malloc(n * sizeof(int));
    int ng = 0, nd = 0;
    for(int i = 1; i < n; i++){
        if (t[i]<pivot){
            ng++;
            g[ng-1] = t[i];
        }
        else{
            nd++;
            d[nd-1] = t[i];
        }
    }
    g = tri_rapide(g, ng);
    d = tri_rapide(d, nd);
    g[ng] = pivot;
    for(int i = 0; i < nd; i++){
        g[ng + 1 + i] = d[i];
    }
}

int algo_naif(int *T, int n, int k){
    T = tri_rapide(T, n);
    return T[k-1];
}

void echanger(int *t, int i, int j){
    int temp = t[i];
    t[i] = t[j];
    t[j] = temp;
}

int separer(int* t, int x, int p, int q){
    echanger(t, x, q);
    for (int j=p; j<=q; j++){
        if (t[j] <= t[q]){
            echanger(t, p, j);
            p++;
        }
    }
    echanger(t, p, q);
    return p;
}

int selection(int *t, int k, int p, int q){
    if (p == q) return t[p];
    int x = rand()%((q-p)+p);
    int i = separer(t, x, p, q);
    if (i == k) return t[i];
    else if (i < k) return t[selection(t, k, i+1, q)];
    else return t[selection(t, k, p, i-1)];
}

int main(){
    int t[] = {3,6,2,8,4,1,5,7};
    int n = 8;
    int k = 4;
    printf("Le %d-ieme plus petit element est %d\n", k, selection(t, k, 0, n-1));
    return 0;
}


