#include <stdio.h>
#include <stdlib.h>
#include "queue.h"
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
insert_edge(graph_t *g, int x, int y, bool directed)
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
read_graph(graph_t *g, bool directed)
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

bool processed[MAXV];
bool discovered[MAXV];
int  parent[MAXV];
int  entry_time[MAXV];
int  exit_time[MAXV];

void
initialize_search(graph_t *g)
{
    int i;

    for(i = 0; i < g->nvertices; ++i) {
        processed[i] = discovered[i] = FALSE;
        exit_time[i] = entry_time[i] = parent[i] = -1;
    }
}

/*
 *  BFS
 */

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

bool finished;
int  time;

edgeclass_t
edge_classification(int x, int y)
{
    if(parent[y] == x) return TREE;
    if(discovered[y] && !processed[y]) return BACK;
    if(processed[y] && (entry_time[y] > entry_time[x])) return FORWARD;
    if(processed[y] && (entry_time[y] < entry_time[x])) return FORWARD;

    printf("Warning: unclassified edge (%d, %d)\n", x, y);
    return UNCLASSIFIED;
}

void
dfs(graph_t *g, int v)
{
    edgenode_t *p;
    int y;

    if(finished) return;

    discovered[v] = TRUE;
    entry_time[v] = ++time;

    process_vertex_early(v);

    for(p = g->edges[v]; p != NULL; p = p->next) {
        y = p->y;
        if(discovered[y] == FALSE) {
            parent[y] = v;
            process_edge(v, y);
            dfs(g, y);
        } else if((!processed[y]) || (g->directed)) {
            process_edge(v, y);
        }
        if(finished) return;
    }

    process_vertex_late(v);
    exit_time[v] = ++time;
    processed[v] = TRUE;
}

#ifdef TEST
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

int
main(int argn, char *argv[])
{
    graph_t g;

    read_graph(&g, FALSE);
    print_graph(&g);
    initialize_search(&g);
    bfs(&g, 0);
    find_path(0, 4); putchar('\n');
    find_path(0, 2); putchar('\n');
}
#endif
