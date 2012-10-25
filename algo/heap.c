#include<stdlib.h>
#include<stdio.h>


#define PQ_SIZE 1024

typedef struct pqueue {
    int q[PQ_SIZE+1];
    int n;
} pqueue_t;

int pq_parent(int n)
{
    if(n == 1) return(-1);
    else return((int)n/2);
}

int pq_young_child(int n) 
{
    return (2*n);
}

void pq_swap(pqueue_t *q, int a, int b)
{
    int t = q->q[a];
    q->q[a] = q->q[b];
    q->q[b] = t;
}

void bubble_up(pqueue_t *q, int p)
{
    if(pq_parent(p) == -1) return;

    if(q->q[pq_parent(p)] > q->q[p]) {
        pq_swap(q, p, pq_parent(p));
        bubble_up(q, pq_parent(p));
    }
}

void pq_insert(pqueue_t *q, int x)
{
    if(q->n >= PQ_SIZE)
        fprintf(stderr, "Warning: priority queue overflow insert x=%d\n",x);
    else {
        q->n = (q->n) + 1;
        q->q[q->n] = x;
        bubble_up(q, q->n);
    }
}

void pq_init(pqueue_t *q)
{
    q->n = 0;
}

void make_heap(pqueue_t *q, int s[], int n)
{
    int i;
    pq_init(q);
    for(i = 0; i <n; ++i)
        pq_insert(q, s[i]);
}

void bubble_down(pqueue_t *q, int p)
{
    int c = pq_young_child(p);
    int min_index = p;
    int i;

    for(i = 0; i <= 1; ++i)
        if((c+i) <= q->n) {
            if(q->q[min_index] > q->q[c+i]) min_index = c+i;
        }

    if(min_index != p) {
        pq_swap(q, p, min_index);
        bubble_down(q, min_index);
    }
}

int extract_min(pqueue_t *q)
{
    int min = -1;
    if(q->n <= 0) fprintf(stderr, "Warning: empty priority queue.\n");
    else {
        min = q->q[1];
        q->q[1] = q->q[q->n];
        --q->n;
        bubble_down(q, 1);
    }
    return min;
}

void make_heap2(pqueue_t *q, int s[], int n)
{
    int i;

    q->n = n;
    for(i = 0; i < n; ++i) q->q[i+1] = s[i];
    for(i = q->n; i >= 1; --i) bubble_down(q, i);
}

void my_heapsort(int s[], int n)
{
    int i;
    pqueue_t q;

    make_heap(&q, s, n);
    for(i = 0; i < n; ++i)
        s[i] = extract_min(&q);
}


#ifdef TEST
int
main(int argn, char *argv[])
{
    int i, n;
    pqueue_t q;

    n = atoi(argv[1]);

    pq_init(&q);

    for(i = 0; i < n; ++i) {
        pq_insert(&q, random()%PQ_SIZE);
    }

    for(i = 0; i < n; ++i)
        printf("%d\n", extract_min(&q));
    return 0;

}
#endif
