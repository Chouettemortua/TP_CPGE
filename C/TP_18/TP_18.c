#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

#define HEAP_SIZE 32
uint64_t heap[HEAP_SIZE];
const uint64_t block_size = 8;
const uint64_t prologue = 3;

void set_memory(uint64_t *p, uint64_t n, uint64_t value)
{
    for (uint64_t i = 0; i < n; i++)
    {
        p[i] = value;
    }
}

bool is_free(uint64_t i)
{
    return heap[i - 1] % 2 == 0;
}

int read_size(uint64_t i)
{
    return heap[i - 1] - (heap[i - 1] % 2);
}

void set_free(uint64_t i, uint64_t size)
{
    heap[i - 1] = size;
    heap[i + size] = size;
}

void set_used(uint64_t i, uint64_t size)
{
    heap[i - 1] = size + 1;
    heap[i + size] = size + 1;
}

uint64_t next(uint64_t i)
{
    return i + read_size(i) + 2;
}

uint64_t previous(uint64_t i)
{
    return i - 2 - heap[i - 2] + (heap[i - 2] % 2);
}

void add_begin_chain(uint64_t i){
    if(heap[1]==0){
        heap[1] = i;
        heap[i] = 0;
        heap[i+1] = 0;
    }
    else{
        heap[i]=0;
        heap[heap[1]] = i;
        heap[i+1] = heap[1];
        heap[1]=i;
    }
}

void remove_from_chain(uint64_t i){
    heap[heap[i]+1] = heap[i+1];
    heap[heap[i+1]] = heap[i];
}

//* free q6 complexité contante
void free_ui(uint64_t *p)
{
    uint64_t i = p - &heap[0];
    int size = read_size(i);

    if (is_free(next(i)))
    {
        remove_from_chain(next(i));
        size += read_size(next(i));
    }

    if (is_free(previous(i)))
    {
        remove_from_chain(previous(i));
        size += read_size(previous(i));
        i = previous(i);
    }

    set_free(i, size);
    add_begin_chain(i);

    if (next(i) == heap[0])
    {   
        remove_from_chain(i);
        heap[0] = i;
        set_used(i, 0);
    }
}

void init_heap(void)
{
    heap[0] = 5;
    heap[1] = 0;
    for (uint64_t i = 2; i <= 5; i++)
    {
        heap[i] = 1;
    }
}

//* maloc q2 complexité constante
//* maloc q5 complexité constante
uint64_t *malloc_ui(uint64_t size)
{
    size = size + (size % 2);
    for (int i = heap[1]; i != 0; i = heap[i+1])
    {
        int size_i = read_size(i);
        if (size <= size_i)
        {
            if (size == size_i)
            {
                set_used(i, size_i);
                return &heap[i];
            }
            int size_part = size_i - size;
            if (size_part >= 4)
            {
                set_used(i, size);
                set_free(next(i), size_part);
                return &heap[i];
            }
        }
    }

    if (heap[0] + size + 2 >= HEAP_SIZE)
    {
        printf("out of memory attribution\n");
        return NULL;
    }
    uint64_t *p = &heap[heap[0]];
    set_used(heap[0], size);
    set_used(next(heap[0]), 0);
    heap[0] = next(heap[0]);
    return p;
}

int main(void)
{
    init_heap();
    uint64_t *p1 = malloc_ui(2);
    uint64_t *p2 = malloc_ui(2);
    uint64_t *p3 = malloc_ui(2);
    uint64_t *p4 = malloc_ui(2);
    uint64_t *p5 = malloc_ui(1);
    uint64_t *p6 = malloc_ui(1);
    set_memory(p1, 2, 42);
    set_memory(p2, 2, 52);
    set_memory(p3, 2, 62);
    set_memory(p4, 2, 72);
    set_memory(p5, 1, 82);
    set_memory(p6, 1, 92);
    free_ui(p1);
    free_ui(p5);
    free_ui(p3);
    for (int i = 0; i < HEAP_SIZE; i++)
    {
        printf("| %lu ", heap[i]);
    }
    printf(" |\n");
}
