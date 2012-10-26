#include <stdio.h>
#include <stdlib.h>
#include "graph.h"

int reachable_ancestor[MAXV];
int tree_out_degree[MAXV];

void
process_vertex_early(int v)
{
    reachable_ancestor[v] = v;
};

void
process_edge(int x, int y)
{
    int class;

    class = edge_classification(x, y);

    if(class == TREE)
        ++tree_out_degree[x];

    if((class == BACK) && (parent[x] != y)) {
        if(entry_time[y] < entry_time[reachable_ancestor[x]])
            reachable_ancestor[x] = y;
    }
}

void
process_vertex_late(int v)
{
    bool root;
    int time_v;
    int time_parent;

    if(parent[v] < 0) {
        if(tree_out_degree[v] > 1)
            printf("root articulation vertex: %d\n", v);
        return;
    }

    root = (parent[parent[v]] < 0);
    if((reachable_ancestor[v] == parent[v]) && (!root))
        printf("parent articulation vertex: %d\n", parent[v]);

    if(reachable_ancestor[v] == v) {
        printf("bridge articulation vertex: %d\n", parent[v]);

        if(tree_out_degree[v] > 0)
            printf("bridge articulation vertex: %d\n", v);
    }

    time_v = entry_time[reachable_ancestor[v]];
    time_parent = entry_time[reachable_ancestor[parent[v]]];

    if(time_v < time_parent)
        reachable_ancestor[parent[v]] = reachable_ancestor[v];
}

int
main(int argn, char *argv[])
{
    graph_t g;
    int i;

    read_graph(&g, FALSE);
    print_graph(&g);

    initialize_search(&g);
    dfs(&g, 0);
}
