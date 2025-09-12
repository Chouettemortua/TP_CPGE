//
// TP.XXIX « Autour du tri rapide, en C »
//
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include <string.h>
#include <time.h>

///////////////
// Squelette //
///////////////

void print_array(int* t, int n) {
    printf("[");
    for (int i = 0; i < n; i++) {
        printf("%d ", t[i]);
    }
    printf("]\n");
}

int* range(int a, int b) {
    assert(b >= a);
    int* t = malloc((b - a) * sizeof(int));
    for (int i = 0; i < b - a; i++) {
        t[i] = a + i;
    }
    return t;
}

int* random_array(int len, int bound) {
    int* arr = malloc(len * sizeof(int));
    for (int i = 0; i < len; i++) {
        arr[i] = rand() % bound;
    }
    return arr;
}

int* copy(int* arr, int len) {
    int* arr_copy = malloc(len * sizeof(int));
    // cette fonction memcpy est hors programme, pas grave pour vous !
    memcpy(arr_copy, arr, len * sizeof(int));
    return arr_copy;
}

bool is_sorted(int* t, int len) {
    for (int i = 1; i < len; i++) {
        if (t[i] < t[i - 1]) {
            return false;
        }
    }
    return true;
}

bool is_equal(int* arr1, int* arr2, int len) {
    for (int i = 0; i < len; i++) {
        if (arr1[i] != arr2[i]) {
            return false;
        }
    }
    return true;
}

// Tri par insertion, si besoin pour comparer
void insertion_sort(int* arr, int len) {
    for (int i = 1; i < len; i++) {
        int j = i;
        int x = arr[i];
        while (j > 0 && x < arr[j - 1]) {
            arr[j] = arr[j - 1];
            j--;
        }
        arr[j] = x;
    }
}


/////////////////////
// Tri rapide en C //
/////////////////////

void swap(int* t, int i, int j){
    int temp = t[i];
    t[i] = t[j];
    t[j] = temp;
};

int partition(int* t, int len){
    int piv = 0;
    int j = 1;
    for(int i = 1; i<len; i++){
        if (t[i]<=t[piv]){
            swap(t, i, j);
            j++;
        }
    }
    swap(t, j-1, piv);
    return j-1;
};

void quicksort(int* t, int n){
    if(n<1){return;}
    int i = partition(t, n);
    quicksort(&t[i+1],n-i-1);
    quicksort(t,i);
};

void test_quicksort(int maxlen, int iterations, int bound){
    for(int i = 0; i<iterations; i++){
        int *arr = random_array(maxlen, bound);
        int* tab = copy(arr, maxlen);
        quicksort(arr, maxlen);
        insertion_sort(tab, maxlen);
        assert(is_equal(arr, tab, maxlen));
        free(arr);
        free(tab);
    }
};


/////////////////
// Quickselect //
/////////////////

/////////////////////
// Exercice XXXII.3//
/////////////////////

// select(t,0) donne le min de t et select(t,n-1) donne le max de t
// on fait select(t, n/2)

/////////////////////
// Exercice XXXII.4//
/////////////////////

int quickselect_aux(int* t, int k, int len){
    assert(k>=0 && k<len);
    int i = partition(t, len);
    if(k = t[i])
        {return t[i];}
    if(k<t[i])
        {return quickselect_aux(t,k,i);}
    else
        {return quickselect_aux(&t[i+1],k-i-1,len-i-1);}
};

int quickselect(int* t, int k, int len){
    assert(k>=0 && k<len);
    int* tab = copy(t, len);
    int res = quickselect_aux(tab, k, len);
    free(tab);
    return res;
};


///////////////
// Introsort //
///////////////

// Exercice XXXII.5
/////////////////////

void siftdown(int* heap, int i, int len);

void extract_max(int* heap, int len);

void heapify(int* heap, int len);

void heapsort(int* heap, int len);


// Exercice XXXII.6
/////////////////////
void introsort(int* t, int len);

void bench(void sort_function(int*, int), int* arr, int len){
    clock_t start = clock();
    sort_function(arr, len);
    double elapsed = 1.0 * (clock() - start) / CLOCKS_PER_SEC;
    double ns_per_element = elapsed / len * 1e9;
    assert(is_sorted(arr, len));
    printf("n = %d, time = %.3f, per element = %.1f ns", len, elapsed, ns_per_element);
}

int compare(const void *x, const void *y) {
    int a = *(const int*)x;
    int b = *(const int*)y;
    return a - b;
}


// Fonction main
//////////////////

// int main() {
int main(int argc, char* argv[]) {
    int* arr = random_array(10,100);
    print_array(arr,10);
    printf("%d\n", quickselect(arr,5,10));
    quicksort(arr, 10);
    print_array(arr,10);
    free(arr);
    // // Tests
    // // test_quicksort(maxlen, iterations, bound, random);
    test_quicksort(1000, 10, 100);
    // // Tests dépendant des arguments de ligne de commande
    if (argc < 4) {
        printf("usage: %s maxlen iterations bound\n", argv[0]);
    } 
    else {
        int maxlen = atoi(argv[1]);
        int iterations = atoi(argv[2]);
        int bound = atoi(argv[3]);
        test_quicksort(maxlen, iterations, bound);
    }
    return EXIT_SUCCESS;
}
