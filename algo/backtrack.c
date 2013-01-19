#include <stdio.h>
#include "graph.h"

#define NMAX 1000
#define MAXCANDIDATES 1000

bool finished = FALSE;

#ifdef SUBSETS
typedef int  data;

int
is_a_solution(int a[], int k, data n)
{
    return (k == n);
}

void
construct_candidates(int a[], int k, data n, int c[], int *ncandidates)
{
    c[0] = TRUE;
    c[1] = FALSE;
    *ncandidates = 2;
}

void
process_solution(int a[], int k, data n)
{
    int i;
    printf("{");
    for(i = 1; i <= k; ++i) {
        if(a[i] == TRUE) printf(" %d", i);
    }
    printf(" }\n");
}

int
main(int argn, char *argv[])
{
    int a[NMAX];

    if(argn < 2) return 1;

    backtrack(a, 0, atoi(argv[1]));
}

void make_move(int a[], int k, data input) {}
void unmake_move(int a[], int k, data input) {}
#elif PERMS
typedef int  data;

int
is_a_solution(int a[], int k, data n)
{
    return (k == n);
}

void
construct_candidates(int a[], int k, data n, int c[], int *ncandidates)
{
    int i;

    bool in_perm[NMAX];

    for(i = 1; i < NMAX; ++i) in_perm[i] = FALSE;
    for(i = 1; i < k; ++i) in_perm[a[i]] = TRUE;

    *ncandidates = 0;
    for(i = 1; i <= n; ++i) {
        if (in_perm[i] == FALSE) {
            c[*ncandidates] = i;
            ++*ncandidates;
        }
    }
}

void
process_solution(int a[], int k, data n)
{
    int i;
    printf("(");
    for(i = 1; i <= k; ++i) printf(" %d", a[i]);
    printf(" )\n");
}

int
main(int argn, char *argv[])
{
    int a[NMAX];

    if(argn < 2) return 1;

    backtrack(a, 0, atoi(argv[1]));
}

void make_move(int a[], int k, data input) {}
void unmake_move(int a[], int k, data input) {}
#elif PATHS
typedef struct {
    graph_t graph;
    int start;
    int end;
} data;

int
is_a_solution(int a[], int k, data n)
{
    return (a[k] == n.end);
}

void
construct_candidates(int a[], int k, data n, int c[], int *ncandidates)
{
    int i;
    bool in_sol[NMAX];
    edgenode_t *p;
    int last;

    for(i = 1; i < NMAX; ++i) in_sol[i] = FALSE;
    for(i = 1; i < k; ++i) in_sol[a[i]] = TRUE;

    if (k == 1) {
        c[0] = n.start;
        *ncandidates = 1;
    } else {
        *ncandidates = 0;
        last = a[k-1];
        p = n.graph.edges[last];
        while (p != NULL) {
            if(!in_sol[p->y]) {
                c[*ncandidates] = p->y;
                ++*ncandidates;
            }
            p = p->next;
        }
    }
}

void
process_solution(int a[], int k, data n)
{
    int i;
    printf("[");
    for(i = 1; i <= k; ++i) printf(" %d", a[i]);
    printf(" ]\n");
}

int
main(int argn, char *argv[])
{
    int a[NMAX];
    data input;

    if(argn < 3) return 1;

    read_graph(&input.graph, TRUE);
    input.start = atoi(argv[1]);
    input.end = atoi(argv[2]);

    backtrack(a, 0, input);
}

void make_move(int a[], int k, data input) {}
void unmake_move(int a[], int k, data input) {}
void process_vertex_late(int v) {}
void process_vertex_early(int v) {}
void process_edge(int x, int y) {}
#endif

backtrack(int a[], int k, data input)
{
    int c[MAXCANDIDATES];
    int ncandidates;
    int i;

    if (is_a_solution(a,k,input)) {
        process_solution(a,k,input);
    } else {
        ++k;
        construct_candidates(a,k,input,c,&ncandidates);
        for (i = 0; i < ncandidates; ++i) {
            a[k] = c[i];
            make_move(a,k,input);
            backtrack(a,k,input);
            unmake_move(a,k,input);
            if (finished) return;
        }
    }
}


