//
// Squelette du TP
//
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

// les clés sont des entiers
typedef int item;

// une structure récursive pour un noeud :
struct Node
{
    item key;           // une clé
    struct Node *left;  // un sous-arbre gauche
    struct Node *right; // un sous-arbre droit
};

// et "struct Node" étant long à écrire, on l'abrège en "node"
typedef struct Node node;

// et un ABR (Binary Search Tree) est juste un enrobage vers un node* qui est la racine
struct BST
{
    node *root;
};
// idem
typedef struct BST bst;

//
// Exercice 1
//

node *new_node(item x)
{
    node *n = (node *)malloc(sizeof(node));
    n->key = x;
    n->left = NULL;
    n->right = NULL;
    return n;
}

bst *bst_make_empty(void)
{
    bst *abr = (bst *)malloc(sizeof(bst));
    abr->root = NULL;
    return abr;
}

void node_free(node *n)
{
    if (n == NULL)
    {
        free(n);
    }
    if (n->left != NULL)
    {
        node_free(n->left);
    }
    if (n->right != NULL)
    {
        node_free(n->right);
    }
    free(n);
}

void bst_free(bst *t)
{
    if (t->root != NULL)
    {
        node_free(t->root);
    }
    free(t);
}

//
// Exercice 2
//

node *node_insert(node *t, item x)
{
    if (t == NULL)
    {
        t = new_node(x);
    }
    if (t->key > x)
    {
        t->left = node_insert(t->left, x);
    }
    if (t->key < x)
    {
        t->right = node_insert(t->right, x);
    }
    return t;
}

void bst_insert(bst *t, item x)
{
    t->root = node_insert(t->root, x);
}

bst *bst_from_array(item arr[], int len)
{
    bst *abr = bst_make_empty();

    for (int i = 0; i < len; i++)
    {
        bst_insert(abr, arr[i]);
    }

    return abr;
}

//
// Exercice 3
//

item node_min(node *n)
{
    assert(n != NULL);
    while (n->left != NULL)
    {
        n = n->left;
    }
    return n->key;
}

item bst_min(bst *t)
{
    return node_min(t->root);
}

bool node_member(node *n, item x)
{
    if (n == NULL)
    {
        return false;
    }
    if (x == n->key)
    {
        return true;
    }
    if (x < n->key)
    {
        return node_member(n->left, x);
    }
    return node_member(n->right, x);
}

bool bst_member(bst *t, item x)
{
    return node_member(t->root, x);
}

// Test si bst_member et bst_from_array marchent bien
void test_member(void)
{
    int n = 6;
    item arr[] = {50, 30, 20, 60, 40, 10};
    bst *t = bst_from_array(arr, 6);
    for (int i = 0; i < n; i++)
    {
        assert(bst_member(t, arr[i]));
        assert(!bst_member(t, 1 + arr[i]));
    }
    printf("test_member() : OK !\n");
}

int node_size(node *n)
{
    if (n == NULL)
    {
        return 0;
    }
    return 1 + node_size(n->left) + node_size(n->right);
}

int bst_size(bst *t)
{
    return node_size(t->root);
}

int max(int a, int b)
{
    if (a > b)
    {
        return a;
    }
    return b;
}

int node_height(node *n)
{
    if (n == NULL)
    {
        return -1;
    }
    return 1 + max(node_height(n->left), node_height(n->right));
}

int bst_height(bst *t)
{
    return node_height(t->root);
}

void node_write_to_array(node *n, item arr[], int *offset_ptr)
{
    if (n != NULL)
    {
        if (n->left != NULL)
        {
            node_write_to_array(n->left, arr, offset_ptr);
        }

        arr[*offset_ptr] = n->key;
        (*offset_ptr)++;

        if (n->right != NULL)
        {
            node_write_to_array(n->right, arr, offset_ptr);
        }
    }
}

item *bst_to_array(bst *t, int *nb_elts)
{
    *nb_elts = bst_size(t);
    item *tab = malloc(sizeof(item) * (*nb_elts));
    int *offset = 0;
    node_write_to_array(t->root, tab, offset);
    return tab;
}

//
// Exercice 4
//

node *node_extract_min(node *n, item *min_ptr)
{
    if (n == NULL)
    {
        return n
    }

    if (n->left != NULL)
    {
        n->left = node_extract_min(n->left, min_ptr);
        return n;
    }

    *min_ptr = n->key;
    return n->right;
}

node *node_delete(node *n, item x)
{
    if (n == NULL)
    {
        return n
    }
    if (x < n->key)
    {
        n->left = node_delete(n->left, x);
    }
    if (x > n->key)
    {
        n->right = node_delete(n->right, x);
    }
    if (x == n->key)
    {
        item *min_prt;
        node_extract_min(n, min_prt);
        n = new_node(*min_prt);
    }
    return n
}

//
// Exercice 5
//

// rand_between(lo, hi) renvoie un entier aléatoire entre low (inclus) et high (exclus).
//
// Pas parfaitement uniforme, mais presque comme si,
//  à condition que (high - low) soit bien plus petit que RAND_MAX.
int rand_between(int low, int high)
{
    int x = rand();
    return low + x % (high - low);
}

// Mélange (applique une permutation aléatoire) au tableau donné en argument.
// On peut supposer qu'elle fait une vraie permutation aléatoire tirée dans Sigma_len.
// (même si ce n'est pas vrai ici, ça suffira en pratique).
void shuffle(item arr[], int len)
{
    assert(len < RAND_MAX);
    for (int i = 0; i < len; i++)
    {
        int j = rand_between(i, len);
        item tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
    }
}

//
// TODO: vous devez rédiger des tests et des exemples dans votre main() au fur et à mesure
//

int main(void)
{
    // TODO:
    test_member();

    // TODO: activer ce test quand vous avez écrit bst_from_array
    // test_member();

    return EXIT_SUCCESS;
}
