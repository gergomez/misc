#include<stdlib.h>
#include<stdio.h>

typedef struct queue {
    int *q;
    size_t size;
    int n;
    int p;
} queue_t;

void init_queue(queue_t *q);
int empty_queue(queue_t *q);
void enqueue(queue_t *q, int x);
int dequeue(queue_t *q);
int headq(queue_t *q);
void my_mergesort(int s[], int l, int h);
