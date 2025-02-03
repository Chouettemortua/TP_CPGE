#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

typedef int datatype;

struct Node {
    datatype data;
    struct Node *next;
};

typedef struct Node node;

node *new_node(datatype data){
    node *n = malloc(sizeof(node));
    n ->data = data;
    n ->next = NULL;
    return n;
}

node *cons(node *list, datatype data){
    node *n = new_node(data);
    n -> next = list;
    return n;
}

node *from_array(datatype array[], int len){
    if(len==0){return NULL;}
    node *n = new_node(array[len-1]);
    for(int i=len-2; i>=0; i--){
        n = cons(n, array[i]);
    }
    return n;
}

void free_list(node *u){
    if(u==NULL){free(u);}
    else{
    node *u_n = u->next;
    free(u);
    free_list(u_n);
    }
}

int length_rec(node *u){
    if(u==NULL){return 0;}
    return 1+length_rec(u->next);
}

int length(node *u){
    int i=0;
    while (u!=NULL){
        u = u->next;
        i++;
    }
    return i;
}

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

void print_list(node *u, bool newline){
    if((u==NULL)&(newline)){printf("\n");}
    if(u!=NULL){
        printf("%d ", u->data);
        print_list(u->next, newline);
    }
}

datatype *to_array(node *u){
    int l = length(u);
    datatype *arr = malloc(sizeof(datatype)*l);
    for(int i=0; i<l; i++){
        arr[i] = u->data;
        u = u->next;
    }
    return arr;
}

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

bool is_equal(node *u, node *v){
    if((u==NULL)&(v==NULL)){return true;}
    if(length(u)!=length(v)){return false;}
    if(u->data==v->data){return is_equal(u->next,v->next);}
    return false;
}

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

bool is_sorted(node *u){
    if(u==NULL){return true;}
    int l = length(u);
    datatype pre = u->data;
    u = u->next;
    for(int i=1; i<l; i++){
        if(pre>u->data){return false;}
        pre = u->data;
        u = u->next;
    }
    return true;
}

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

node *insert_rec(node *u, datatype x){
    if(u==NULL){return new_node(x);}
    if(u->data>x){return cons(u, x);}
    u->next = insert_rec(u->next, x);
    return u;
}

node *insertion_sort_rec(node *u){
    if(u==NULL){return NULL;}
    int l = length(u);
    node *n = new_node(u->data);
    u = u->next;
    for(int i=1; i<l; i++){
        insert_rec(n, u->data);
        u = u->next;
    }
    return n;
}

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

int main(void){
    int array[] = {1,2,3,4,5};
    node *n = from_array(array, 5);
    //print_list(n, false);
    //printf("test\n");
    free_list(n);
    test_length();
    test_to_array();
    test_is_equal();
    test_is_sorted();
    test_insertion_sort_rec();
    return 0;
}