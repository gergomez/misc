#include<stdlib.h>
#include<stdio.h>

#define QSIZE 128

typedef struct queue {
    int *q;
    size_t size;
    size_t nel;
    size_t w;
    size_t r;
} cqueue_t;

void init_cqueue(cqueue_t *q)
{
    q->q = (int *)malloc(sizeof(int)*QSIZE);
    q->size = QSIZE;
    q->nel = 0;
    q->w = 0;
    q->r = 0;
}

int empty_cqueue(cqueue_t *q)
{
    return (q->nel == 0);
}

void encqueue(cqueue_t *q, int x)
{
    ++q->nel;
    if(q->nel == q->size) {
        int *t, i;
        t = malloc(sizeof(int)*q->size*2);
        if(NULL == t) {
            fprintf(stderr, "Error: out of memory encqueue(%d)\n", x);
            exit(1);
        }
        for(i = 0; i < q->size; ++i) {
            t[i] = q->q[(q->r + i)%q->size];
        }
        q->q[q->size - 1] = x;
        q->w = q->size;
        q->r = 0;
        q->size *= 2;
    } else {
        q->q[q->w++] = x;
        if(q->w == q->size) {
            q->w = 0;
        }
    }
}

int decqueue(cqueue_t *q)
{
    int t;
    if(q->nel == 0) {
        fprintf(stderr,"Warning: decqueue from empty cqueue\n");
        return -1;
    }
    t = q->q[q->r++];
    --q->nel;
    if(q->r == q->size)
        q->r = 0;
    return t;
}

int headq(cqueue_t *q)
{
    return q->q[q->r];
}

void merge(int s[], int l, int m, int h)
{
    int i;
    cqueue_t buffer1, buffer2;

    init_cqueue(&buffer1);
    init_cqueue(&buffer2);

    for(i = l; i <= m; ++i) encqueue(&buffer1, s[i]);
    for(i = m+1; i <= h; ++i) encqueue(&buffer2, s[i]);

    i = l;
    while(!(empty_cqueue(&buffer1) || empty_cqueue(&buffer2))) {
        if(headq(&buffer1) <= headq(&buffer2))
            s[i++] = decqueue(&buffer1);
        else
            s[i++] = decqueue(&buffer2);
    }
    while(!empty_cqueue(&buffer1)) s[i++] = decqueue(&buffer1);
    while(!empty_cqueue(&buffer2)) s[i++] = decqueue(&buffer2);
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

int
main(int argn, char *argv[])
{
    int i, n;
    int *s;
    cqueue_t q;

    n = atoi(argv[1]);

    init_cqueue(&q);
    encqueue(&q, 0);
    encqueue(&q, 1);
    for(i = 2; i < n; ++i) {
        printf("%zd:%zd:%zd:%zd\n", q.size, q.nel, q.w, q.r);
        encqueue(&q, i);
    }
    printf("--\n");
    while(!empty_cqueue(&q)) {
        printf("%d\n", decqueue(&q));
    }
    return 0;
}
