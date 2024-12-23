#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

//* Part 1
struct int_array{
    int *data;
    int len;
};
typedef struct int_array int_array;

int_array* array_create(int len, int x){

    int_array *t = (int_array*)malloc(sizeof(int_array));
    int* data = (int*)malloc(len*sizeof(int));

    for(int i=0; i<len; i++){
        data[i]=x;
    }
    t->data = data;
    t->len = len;
    return t;
}

int array_get(int_array *t, int i){
    assert(i<t->len);
    return t->data[i];
}

void array_set(int_array *t, int i, int x){
    assert(i<t->len);
    t->data[i] = x;
}

void array_delete(int_array *t){
    free(t->data);
    free(t);
}

//* Part 2
struct int_dynarray{
    int len;
    int capacity;
    int* data;
};
typedef struct int_dynarray int_dynarray;

int lenght(int_dynarray *t){
    return t->len;
}

int_dynarray* make_empty(void){
    int_dynarray *t = (int_dynarray*)malloc(sizeof(int_dynarray));
    t->data = NULL;
    t->len=0;
    t->capacity=0;
    return t;
}

int dynarray_get(int_dynarray *t, int i){
    assert(i<t->len);
    return t->data[i];
}

void dynarray_set(int_dynarray *t, int i, int x){
    assert(i<t->len);
    t->data[i] = x;
}

void resize(int_dynarray *t, int new_capa){
    int* new_data = (int*)malloc(new_capa*sizeof(int));
    for(int i=0; i<t->len; i++){
        new_data[i] = t->data[i];
    }
    t->capacity=new_capa;
    if(t->data!=NULL){
        free(t->data);
    }
    t->data = new_data;
}

int pop(int_dynarray *t){
    if(t->len-1<=t->capacity/4){
        int res = t->data[t->len-1];
        t->len-=1;
        resize(t, t->capacity/2);
        return res;
    }
    t->len-=1;
    return t->data[t->len];
}

void push(int_dynarray *t, int x){
    if(t->len+1>t->capacity){
        if(t->capacity!=0){
            resize(t, t->capacity*2);
        }
        else{resize(t, 1);}
    }
    t->data[t->len] = x;
    t->len+=1;
}

void delete(int_dynarray *t){
    free(t->data);
    free(t);
}

void insert_at(int_dynarray *t, int i, int x){
    int_dynarray *temp = make_empty();
    resize(temp, (t->len)-i);
    for(int j=0; j<t->len-i; j++){
        push(temp, pop(t));
    }
    push(t,x);
    for(int j=0; t->len-i; j++){
        push(t, pop(temp));
    }
    t->len +=1;
    delete(temp);
}

int main(void){
    int_dynarray *t = make_empty();
    for(int i = 0; i<10; i++){
        push(t, i);
    }
    printf("\n");
    printf("val en 5: %d\n", dynarray_get(t,5));
    dynarray_set(t,5,200);
    printf("new val en 5: %d\n", dynarray_get(t,5));
    printf("\n");
    printf("capacity before pop: %d\n",t->capacity);
    printf("len before pop: %d\n",lenght(t));
    for(int i=1;i<=2;i++){
        pop(t);
    }
    printf("\n");
    printf("after pop:\n");
    printf("\n");
    printf("capacity: %d\n",t->capacity);
    printf("len: %d\n",lenght(t));
    printf("\n");
    insert_at(t,7,300);
    for(int i=0;i<lenght(t);i++){
        printf("%d ", t->data[i]);
    }
    delete(t);
    //* array_create(1,1);
}