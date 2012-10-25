#include <stdio.h>
#include <stdlib.h>
#include "queue.h"

#define MAXV 1000
#define FALSE 0
#define TRUE  1

typedef struct edgenode {
    int y;
    int weight;
    struct edgenode *next;
} edgenode_t;

typedef struct graph {
    edgenode_t *edges[MAXV];
    int degree[MAXV];
    int nvertices;
    int nedges;
    char directed;
} graph_t;

void
initialize_graph(graph_t *g, char directed)
{
    int i;

    g->nvertices = 0;
    g->nedges = 0;
    g->directed = directed;

    for(i = 0; i < MAXV; ++i) g->degree[i] = 0;
    for(i = 0; i < MAXV; ++i) g->edges[i] = NULL;
}

void
insert_edge(graph_t *g, int x, int y, char directed)
{
    edgenode_t *p;

    p = malloc(sizeof(edgenode_t));

    p->weight = 0;
    p->y = y;
    p->next = g->edges[x];
    g->edges[x] = p;

    ++g->degree[x];

    if(directed == FALSE)
        insert_edge(g, y, x, TRUE);
    else
        ++g->nedges;
}

void
read_graph(graph_t *g, char directed)
{
    int i, m;
    int x, y;

    initialize_graph(g, directed);

    scanf("%d %d", &(g->nvertices), &m);

    for(i = 0; i < m; ++i) {
        scanf("%d %d", &x, &y);
        insert_edge(g, x, y, directed);
    }
}

void
print_graph(graph_t *g)
{
    int i;
    edgenode_t *p;

    for(i = 0; i < g->nvertices; ++i) {
        printf("%d:", i);
        p =  g->edges[i];
        for(p = g->edges[i]; p != NULL; p = p->next)
            printf(" %d", p->y);
        printf("\n");
    }
}

/*
 *  BFS
 */

char processed[MAXV];
char discovered[MAXV];
int  parent[MAXV];

void
initialize_search(graph_t *g)
{
    int i;

    for(i = 0; g->nvertices; ++i) {
        processed[i] = discovered[i] = FALSE;
        parent[i] = -1;
    }
}

void
process_vertex_late(int v)
{
}

void
process_vertex_early(int v)
{
    printf("Processed vertex %d\n", v);
}

void
process_edge(int x, int y)
{
    printf("Processed edge (%d, %d)\n", x, y);
}

void
bfs(graph_t *g, int start)
{
    queue_t q;
    int v, y;
    edgenode_t *p;

    init_queue(&q);
    enqueue(&q, start);
    discovered[start] = TRUE;

    while(!empty_queue(&q)) {
        v = dequeue(&q);
        process_vertex_early(v);
        processed[v] = TRUE;
        p = g->edges[v];

        while(p != NULL) {
            y = p->y;
            if(!processed[y] || g->directed)
                process_edge(v, y);
            if(!discovered[y]) {
                enqueue(&q, y);
                discovered[y] = TRUE;
                parent[y] = v;
            }
            p = p->next;
        }
        process_vertex_late(v);
    }
}

void
find_path(int start, int end)
{
    if((start == end) || end == -1)
        printf("%d", start);
    else {
        find_path(start, parent[end]);
        printf(" %d", end);
    }
}

#ifdef TEST
int
main(int argn, char *argv[])
{
    graph_t g;

    read_graph(&g, FALSE);
    print_graph(&g);
    bfs(&g, 0);
    find_path(0, 4); putchar('\n');
    find_path(0, 2); putchar('\n');
}
#endif
