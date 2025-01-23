//
// TP23 « structures de données chaînées en C »
// jeudi 23/01/2025
//

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

/*************/
/*  Partie 1 */
/*************/

typedef int datatype;

struct Node {
  datatype data;
  struct Node *next;
};

typedef struct Node node;


// Exercice 1

node *new_node(datatype data);

node *cons(node *list, datatype data);

node *from_array(datatype array[], int len);


// Exercice 2

void free_list(node *n);

void free_list_rec(node *n);

int length(node* list);

void test_length(void){
  assert(length(NULL) == 0);
  node *u = cons(cons(NULL, 3), 4);
  assert(length(u) == 2);
  int t[3] = {2, 4, 6};
  free_list(u);
  u = from_array(t, 3);
  assert(length(u) == 3);
  assert(u->data == 2);
  free_list(u);
}

void print_list(node *n, bool newline);

datatype *to_array(node *u);

void test_to_array(void){
  int t[5] = {1, 2, 3, 4, 5};
  int n = 5;
  node *u = from_array(t, n);
  print_list(u, true);
  int *t2 = to_array(u);
  for (int i = 0; i < n; i++){
    assert(t[i] == t2[i]);
  }
  free(t2);
  free_list(u);
}

bool is_equal(node *u, node *v);

void test_is_equal(void){
  int a[4] = {1, 2, 3, 4};
  int b[4] = {1, 2, 4, 3};

  node *u = from_array(a, 3);
  node *v = from_array(a, 4);
  assert(!is_equal(u, v));
  free_list(u);
  free_list(v);

  u = from_array(a, 4);
  v = from_array(b, 4);
  assert(!is_equal(u, v));
  free_list(u);
  free_list(v);

  u = from_array(a, 2);
  v = from_array(b, 2);
  assert(is_equal(u, v));

  free_list(u);
  free_list(v);
}


// Exercice 3

bool is_sorted(node *u);

void test_is_sorted(void){
  int t[5] = {1, 2, 4, 3, 5};

  node *u = from_array(t, 0);
  assert(is_sorted(u));
  free_list(u);

  u = from_array(t, 1);
  assert(is_sorted(u));
  free_list(u);

  u = from_array(t, 3);
  assert(is_sorted(u));
  free_list(u);

  u = from_array(t, 4);
  assert(!is_sorted(u));
  free_list(u);

  u = from_array(t, 5);
  assert(!is_sorted(u));
  free_list(u);
}

node *insert_rec(node *u, datatype x);

void test_insert_rec(void){
  node *u = NULL;
  u = insert_rec(u, 4);
  u = insert_rec(u, 2);
  u = insert_rec(u, 3);
  u = insert_rec(u, 5);

  int t[4] = {2, 3, 4, 5};
  node *v = from_array(t, 4);
  assert(is_equal(u, v));

  free_list(u);
  free_list(v);
}

node *insertion_sort_rec(node *u);

void test_insertion_sort_rec(void){
  int t[5] = {0, 4, 2, 1, 3};
  int t_sorted[5] = {0, 1, 2, 3, 4};

  node *u = from_array(t, 5);
  node *v = insertion_sort_rec(u);
  node *w = from_array(t_sorted, 5);

  assert(is_equal(v, w));

  free_list(u);
  free_list(v);
  free_list(w);
}


// Exercice 4

node* reverse_copy(node* u);

void test_reverse_copy(void){
  int t[4] = {1, 2, 3, 4};
  int t_rev[4] = {4, 3, 2, 1};
  node *u = from_array(t, 4);
  node *v = from_array(t_rev, 4);

  node *u_rev = reverse_copy(u);
  assert(is_equal(v, u_rev));

  free_list(u);
  free_list(v);
  free_list(u_rev);
}

node *copy_rec(node *u);

void test_copy_rec(void){
  int t1[4] = {1, 2, 3, 4};
  node *u = from_array(t1, 4);
  node *v = copy_rec(u);

  assert(is_equal(u, v));
  free_list(u);
  free_list(v);
}

node* copy(node* u);

void test_copy(void){
  int t1[4] = {1, 2, 3, 4};
  node *u = from_array(t1, 4);
  node *v = copy(u);

  assert(is_equal(u, v));
  free_list(u);
  free_list(v);

  u = NULL;
  v = copy(u);
  assert(is_equal(u, v));
}

node *reverse(node *u);

void test_reverse(void){
  int t[4] = {1, 2, 3, 4};
  node *u = from_array(t, 4);
  node *u_rev = reverse_copy(u);


  u = reverse(u);
  assert(is_equal(u, u_rev));

  free_list(u);
  free_list(u_rev);

  u = NULL;
  u = reverse(u);
  assert(is_equal(u, NULL));
}


// Exercice 5

node *read_list(void);

void print_list_2(node *u);


/*************/
/*  Partie 2 */
/*************/

struct Stack {
  int len;
  node* top;
};

typedef struct Stack stack;

// Exercice 6

stack *empty_stack(void);

datatype peek(stack *s);

void push(stack *s, datatype x);

datatype pop(stack *s);

void free_stack(stack *s);

void test_stack(void){
  stack *s = empty_stack();
  push(s, 1);
  push(s, 2);
  assert(pop(s) == 2);
  push(s, 3);
  assert(pop(s) == 3);
  assert(pop(s) == 1);
  assert(s->len == 0);
  push(s, 10);
  assert(pop(s) == 10);
  free_stack(s);
}


// Files

struct Queue {
  int len;
  node *left;
  node *right;
};

typedef struct Queue queue;


// Exercice 7

queue *empty_queue(void);

void free_queue(queue *q);

datatype peek_left(queue *q);

void push_right(queue *q, datatype data);

datatype pop_left(queue *q);

void test_queue(void){
  queue *q = empty_queue();
  push_right(q, 1);
  push_right(q, 2);
  assert(pop_left(q) == 1);
  push_right(q, 3);
  push_right(q, 4);
  assert(pop_left(q) == 2);
  assert(pop_left(q) == 3);
  assert(pop_left(q) == 4);
  push_right(q, 5);
  assert(pop_left(q) == 5);
  assert(q->len == 0);
  free_queue(q);
}

// Exercice 8

int *hamming(int n);

void test_hamming(void){
  int n = 14;
  int h_ref[14] = {1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20};
  int *h = hamming(14);

  for (int i = 0; i < n; i++){
    assert(h[i] == h_ref[i]);
  }

  free(h);
}

/*************/
/*  Partie 3 */
/*************/

// Exercice 9

node *insert_it(node *u, datatype x);

node *insertion_sort_it(node *u);

void test_insertion_sort_it(void){
  int t[5] = {0, 4, 2, 1, 3};
  int t_sorted[5] = {0, 1, 2, 3, 4};

  node *u = from_array(t, 5);
  node *v = insertion_sort_it(u);
  node *w = from_array(t_sorted, 5);

  assert(is_equal(v, w));

  free_list(u);
  free_list(v);
  free_list(w);
}


// Exercice 10

node *split(node *u, int n);

void test_split(void);

node *merge(node *u, node *v);

node *merge_sort(node *u);

void test_merge_sort(void){
  int t[10] = {1, 4, 0, 2, 3, 8, 5, 6, 6, 7};
  node *u = from_array(t, 10);

  u = merge_sort(u);
  node *u_sorted = insertion_sort_it(u);
  assert(is_equal(u, u_sorted));

  free_list(u);
  free_list(u_sorted);
}


// Fonction main avec les appels aux fonctions de tests
int main(void) {

  // Test #1
  void test_length();
  // Test #2
  // void test_to_array();
  // Test #3
  // void test_is_equal();
  // Test #4
  // void test_is_sorted();
  // Test #5
  // void test_insert_rec();
  // Test #6
  // void test_insertion_sort_rec();
  // Test #7
  // void test_reverse_copy();
  // Test #8
  // void test_copy_rec();
  // Test #9
  // void test_copy();
  // Test #10
  // void test_reverse();
  // Test #11
  // void test_stack();
  // Test #12
  // void test_queue();
  // Test #13
  // void test_hamming();
  // Test #14
  // void test_insertion_sort_it();
  // Test #15
  // void test_split();
  // Test #16
  // void test_merge_sort();

  return 0;
}
