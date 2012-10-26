#include <stdio.h>
#include <stdlib.h>
#include "graph.h"

typedef enum { UNCOLORED = 0, WHITE, RED } color_t;

color_t color[MAXV];

bool bipartite;

void
twocolor(graph_t *g)
{
    int i;

    for(i = 0; i < g->nvertices; ++i)
        color[i] = UNCOLORED;

    bipartite = TRUE;

    initialize_search(g);

    for(i = 0; i < g->nvertices; ++i)
        if(!discovered[i]) {
            color[i] = WHITE;
            bfs(g, i);
        }
}


color_t
complement(color_t color)
{
    if(color == WHITE) return RED;
    if(color == RED) return WHITE;

    return UNCOLORED;
}

void
process_edge(int x, int y)
{
    if(color[x] == color[y]) {
        bipartite = FALSE;
        printf("Warning: not bipartite due to (%d, %d)\n", x, y);
    }
    color[y] = complement(color[x]);
}

void process_vertex_late(int v) {};
void process_vertex_early(int v) {};

#ifdef TEST
int
main(int argn, char *argv[])
{
    graph_t g;

    read_graph(&g, FALSE);
    print_graph(&g);

    twocolor(&g);
    if (bipartite) {
        printf("Graph is BIPARTITE!\n");
    }
}
#endif
