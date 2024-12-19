#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#define HEAP_SIZE 32
uint64_t heap[HEAP_SIZE];
u_int64_t block_size = 8;

void set_memory(uint64_t *p, uint64_t n, uint64_t value)
{
    for (uint64_t i = 0; i < n; i++)
    {
        p[i] = value;
    }
}

bool is_free(uint64_t i)
{
    return heap[i - 1] == 0;
}

void set_free(uint64_t i)
{
    heap[i - 1] = 0;
}

void set_used(uint64_t i)
{
    heap[i - 1] = 1;
}

//* free q6 complexité contante
void free_ui(uint64_t *p)
{
    uint64_t i = p - &heap[0];
    set_free(i);
    if (i == heap[0] - 8)
    {
        heap[0] = i;
    }
}

void init_heap(void)
{
    heap[0] = 2;
}

//* maloc q2 complexité constante
//* maloc q5 complexité constante
uint64_t *malloc_ui(uint64_t size)
{

    if (size >= block_size)
    {
        return NULL;
    }

    for (int i = 2; i < heap[0]; i += block_size)
    {
        if (is_free(i))
        {
            set_used(i);
            return &heap[i];
        }
    }

    if (heap[0] - 2 == HEAP_SIZE)
    {
        return NULL;
    }

    uint64_t *p = &heap[heap[0]];
    set_used(heap[0]);
    heap[0] += block_size;
    return p;
}

int main(void)
{
    init_heap();
    uint64_t *p1 = malloc_ui(6);
    uint64_t *p2 = malloc_ui(3);
    set_memory(p1, 6, 42);
    set_memory(p2, 3, 52);
    for (int i = 0; i < HEAP_SIZE; i++)
    {
        printf("| %lu ", heap[i]);
    }
    printf(" |\n");
}
