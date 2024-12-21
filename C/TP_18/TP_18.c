#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

#define HEAP_SIZE 32
uint64_t heap[HEAP_SIZE];
const u_int64_t block_size = 8;
const uint64_t prologue = 2;

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

//* free q6 complexité contante
void free_ui(uint64_t *p)
{
    uint64_t i = p - &heap[0];
    int size = read_size(i);
    if (is_free(next(i)))
    {
        size += read_size(next(i));
    }
    if (is_free(previous(i)))
    {
        size += read_size(previous(i));
        i = previous(i);
    }
    set_free(i, size);
    if (next(i) == heap[0])
    {
        heap[0] = i;
        set_used(i, 0);
    }
}

void init_heap(void)
{
    heap[0] = 4;
    for (uint64_t i = 1; i <= 4; i++)
    {
        heap[i] = 1;
    }
}

//* maloc q2 complexité constante
//* maloc q5 complexité constante
uint64_t *malloc_ui(uint64_t size)
{
    size = size + (size % 2);
    for (int i = prologue + 2; i < heap[0]; i = next(i))
    {
        int size_i = read_size(i);
        if (is_free(i) && size <= size_i)
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
    uint64_t *p1 = malloc_ui(6);
    uint64_t *p2 = malloc_ui(7);
    uint64_t *p3 = malloc_ui(1);
    set_memory(p1, 6, 42);
    set_memory(p2, 7, 52);
    set_memory(p3, 1, 62);
    free_ui(p2);
    for (int i = 0; i < HEAP_SIZE; i++)
    {
        printf("| %lu ", heap[i]);
    }
    printf(" |\n");
}
