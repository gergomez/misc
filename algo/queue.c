#include<stdlib.h>
#include<stdio.h>

#define QSIZE 128

typedef struct queue {
    int *q;
    size_t size;
    int n;
    int p;
} queue_t;

void init_queue(queue_t *q)
{
    q->q = (int *)malloc(sizeof(int)*QSIZE);
    q->size = QSIZE;
    q->n = 0;
    q->p = 0;
}

int empty_queue(queue_t *q)
{
    return (q->p >= q->n);
}

void enqueue(queue_t *q, int x)
{
    if(q->n >= q->size) {
        q->size *= 2;
        if(NULL == (q->q = (int *)realloc(q->q, sizeof(int)*q->size))) {
            fprintf(stderr, "Error: out of memory enqueue(%d)\n", x);
            exit(1);
        }
    }
    q->q[q->n++] = x;
}

int dequeue(queue_t *q)
{
    if(q->p > q->n) {
        fprintf(stderr,"Warning: dequeue from empty queue\n");
        return -1;
    }
    return q->q[q->p++];
}

int headq(queue_t *q)
{
    return q->q[q->p];
}

void merge(int s[], int l, int m, int h)
{
    int i;
    queue_t buffer1, buffer2;

    init_queue(&buffer1);
    init_queue(&buffer2);

    for(i = l; i <= m; ++i) enqueue(&buffer1, s[i]);
    for(i = m+1; i <= h; ++i) enqueue(&buffer2, s[i]);

    i = l;
    while(!(empty_queue(&buffer1) || empty_queue(&buffer2))) {
        if(headq(&buffer1) <= headq(&buffer2))
            s[i++] = dequeue(&buffer1);
        else
            s[i++] = dequeue(&buffer2);
    }
    while(!empty_queue(&buffer1)) s[i++] = dequeue(&buffer1);
    while(!empty_queue(&buffer2)) s[i++] = dequeue(&buffer2);
}

void my_mergesort(int s[], int l, int h)
{
    int i, m;

    if(l < h) {
        m = (l+h)/2;
        my_mergesort(s, l, m);
        my_mergesort(s, m+1, h);
        merge(s, l, m, h);
    }
}

#ifdef TEST
int
main(int argn, char *argv[])
{
    int i, n;
    int *s;

    n = atoi(argv[1]);

    s = (int *)malloc(sizeof(int)*n);

    for(i = 0; i < n; ++i) {
        s[i] = random();
    }
    my_mergesort(s, 0, n - 1);
    for(i = 0; i < n; ++i) {
        printf("%d\n", s[i]);
    }

    return 0;
}
#endif
