#include "bool.h"

#define MAXV  1000
typedef enum { UNCLASSIFIED = -1, TREE = 0, BACK, FORWARD, CROSS} edgeclass_t;

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
    bool directed;
} graph_t;

extern bool processed[MAXV];
extern bool discovered[MAXV];
extern int  parent[MAXV];
extern int  entry_time[MAXV];
extern int  exit_time[MAXV];

void initialize_graph(graph_t *g, bool directed);
void read_graph(graph_t *g, bool directed);
void print_graph(graph_t *g);

void initialize_search(graph_t *g);
void find_path(int start, int end);

edgeclass_t edge_classification(int x, int y);
void bfs(graph_t *g, int start);

extern bool finished;
extern int  time;
void dfs(graph_t *g, int v);
void prim(graph_t *g, int s);
void dijkstra(graph_t *g, int s);

void process_vertex_late(int v);
void process_vertex_early(int v);
void process_edge(int x, int y);

