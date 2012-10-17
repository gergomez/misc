#include<stdlib.h>
#include<stdio.h>


void my_quicksort(int s[], int l, int h)
{
    int p;

    if((h - l) > 0) {
        p = partition(s, l, h);
        my_quicksort(s, l, p - 1);
        my_quicksort(s, p + 1, h);
    }
}

void swap(int *a, int *b)
{
    int t;

    if (a == b) return;

    t = *a;
    *a = *b;
    *b = t;
}

int partition(int s[], int l, int h)
{
    int i, p, fh;

    p = h;
    fh = l;
    for(i = l; i < h; ++i)
        if(s[i] < s[p]) {
            swap(&s[i], &s[fh]);
            ++fh;
        }
    swap(&s[p],&s[fh]);
    return fh;
}

int
main(int argn, char *argv[])
{
    int i, n;
    int *s;

    n = atoi(argv[1]);

    s = (int *)malloc(sizeof(int)*n);

    for(i = 0; i < n; ++i)
        s[i] = random();

    my_quicksort(s, 0, n - 1);

    for(i = 0; i < n; ++i)
        printf("%d\n", s[i]);
    return 0;
}
