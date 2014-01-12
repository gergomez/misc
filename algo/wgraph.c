#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include "graph.h"

void
initialize_graph(graph_t *g, bool directed)
{
    int i;

    g->nvertices = 0;
    g->nedges = 0;
    g->directed = directed;

    for(i = 0; i < MAXV; ++i) g->degree[i] = 0;
    for(i = 0; i < MAXV; ++i) g->edges[i] = NULL;
}

void
insert_edge(graph_t *g, int x, int y, bool directed, int weight)
{
    edgenode_t *p;

    p = malloc(sizeof(edgenode_t));

    p->weight = weight;
    p->y = y;
    p->next = g->edges[x];
    g->edges[x] = p;

    ++g->degree[x];

    if(directed == FALSE)
        insert_edge(g, y, x, TRUE, weight);
    else
        ++g->nedges;
}

void
read_graph(graph_t *g, bool directed)
{
    int i, m;
    int x, y, w;

    initialize_graph(g, directed);

    scanf("%d %d", &(g->nvertices), &m);

    for(i = 0; i < m; ++i) {
        scanf("%d %d %d", &x, &y, &w);
        insert_edge(g, x, y, directed, w);
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
            printf(" %d(%d)", p->y, p->weight);
        printf("\n");
    }
}

int  parent[MAXV];

void
prim(graph_t *g, int s)
{
    int i;
    edgenode_t *p;
    bool intree[MAXV];
    int distance[MAXV];
    int v, w, weight, dist;

    for(i = 0; i < g->nvertices; ++i) {
        intree[i] = FALSE;
        distance[i] = INT_MAX;
        parent[i] = -1;
    }

    distance[s] = 0;
    v = s;

    while(intree[v] == FALSE) {
        intree[v] = TRUE;
        p = g->edges[v];
        while (p != NULL) {
            w = p->y;
            weight = p->weight;
            if ((distance[w] > weight) && (intree[w] == FALSE)) {
                distance[w] = weight;
                parent[w] = v;
            }
            p = p->next;
        }

        v = 0;
        dist = INT_MAX;
        for (i = 0; i < g->nvertices; ++i) {
            if ((intree[i] == FALSE) && (dist > distance[i])) {
                dist = distance[i];
                v = i;
            }
        }
    }
}

void
dijkstra(graph_t *g, int s)
{
    int i;
    edgenode_t *p;
    bool intree[MAXV];
    int distance[MAXV];
    int v, w, weight, dist;

    for(i = 0; i < g->nvertices; ++i) {
        intree[i] = FALSE;
        distance[i] = INT_MAX;
        parent[i] = -1;
    }

    distance[s] = 0;
    v = s;

    while(intree[v] == FALSE) {
        intree[v] = TRUE;
        p = g->edges[v];
        while (p != NULL) {
            w = p->y;
            weight = p->weight;
            if (distance[w] > (distance[v] + weight)) {
                distance[w] = distance[v] + weight;
                parent[w] = v;
            }
            p = p->next;
        }

        v = 0;
        dist = INT_MAX;
        for (i = 0; i < g->nvertices; ++i) {
            if ((intree[i] == FALSE) && (dist > distance[i])) {
                dist = distance[i];
                v = i;
            }
        }
    }
}

void
find_path(int start, int end)
{
    if((start == end) || end == -1) {
        printf("%d", start);
    } else {
        find_path(start, parent[end]);
        printf(" %d", end);
    }
}

void
print_spanning_tree(graph_t *g, int s)
{
    edgenode_t *p;

    for(p = g->edges[s]; p != NULL; p = p->next) {
        if (parent[p->y] == s) {
            print_spanning_tree(g, p->y);
            printf(" %d", s);
        }
    }
}

#ifdef TEST
int
main(int argn, char *argv[])
{
    graph_t g;

    read_graph(&g, FALSE);
    print_graph(&g);
    dijkstra(&g, 0);
    if(argn > 1) {
        find_path(0, atoi(argv[1]));
    }
}
#endif
