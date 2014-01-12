#include <stdio.h>
#include <stdlib.h>
#include "graph.h"

void process_vertex_early(int v) {}
void process_vertex_late(int v) {}

void
process_edge(int x, int y)
{
    if(parent[x] != y) {
        printf("Cycle from %d to %d:", y, x);
        find_path(y, x);
        printf("\n");
    }
}

int
main(int argn, char *argv[])
{
    graph_t g;

    read_graph(&g, TRUE);
    print_graph(&g);

    initialize_search(&g);
    dfs(&g, 0);
}
