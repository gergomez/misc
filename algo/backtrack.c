#include <stdio.h>
#include "bool.h"

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
#include "graph.h"

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
#elif SUDOKU
#define DIMENSION 9
#define NCELLS DIMENSION*DIMENSION

typedef struct {
    int x,y;
} point_t;

typedef struct {
    int m[DIMENSION+1][DIMENSION+1];
    int freecount;
    point_t move[NCELLS+1];
} board_t, *data;

size_t num_calls = 0;

int
is_a_solution(int a[], int k, data board)
{
    ++num_calls;
    return (board->freecount  == 0);
}

void
possible_values(int *x, int *y, data board, bool possible[])
{
    int k, l, m;
    bool res[DIMENSION+1];

    m = 10;
    *x = -1;
    *y = -1;

    for(k = 1; k < DIMENSION + 1; ++k) {
        for(l = 1; l < DIMENSION + 1; ++l) {
            int i, j, n;
            int sectx, secty;

            if (board->m[k][l] > 0) continue;

            for(i = 1; i < DIMENSION+1; ++i) res[i] = TRUE;

            for(i = 1; i < DIMENSION+1; ++i) {
                if(board->m[k][i] > 0) res[board->m[k][i]] = FALSE;
                if(board->m[i][l] > 0) res[board->m[i][l]] = FALSE;
            }
            sectx = (k-1)/3*3 + 1;
            secty = (l-1)/3*3 + 1;
            for(i = 0; i < 3; ++i)
                for(j = 0; j < 3; ++j)
                    if(board->m[sectx+i][secty+j] > 0)
                        res[board->m[sectx+i][secty+j]] = FALSE;

            n = 0;
            for(i = 1; i < DIMENSION+1; ++i) {
                if(res[i]) ++n;
            }
            if(n < m) {
                *x = k;
                *y = l;
                m = n;
                for(i = 1; i < DIMENSION+1; ++i) possible[i] = res[i];
            }
        }
    }
}

void
print_board(data board)
{
    int i, j;

    for(i = 1; i < DIMENSION + 1; ++i) {
        for(j = 1; j < DIMENSION + 1; ++j)
            printf("%d ", board->m[i][j]);
        printf("\n");
    }
}

void
fill_square(int x, int y, int v, data board)
{
    board->m[x][y] = v;
    --board->freecount;
}

void
free_square(int x, int y, int v, data board)
{
    board->m[x][y] = 0;
    ++board->freecount;
}

void
construct_candidates(int a[], int k, data board, int c[], int *ncandidates)
{
    int x, y;
    int i;
    bool possible[DIMENSION+1];

    possible_values(&x,&y,board,possible);

    if((x<0) && (y<0)) return; /* No valid moves */

    board->move[k].x = x;
    board->move[k].y = y;

    *ncandidates = 0;
    for(i = 1; i <= DIMENSION; ++i) {
        if (possible[i] == TRUE) {
            c[*ncandidates] = i;
            ++*ncandidates;
        }
    }
}

void
process_solution(int a[], int k, data board)
{
    print_board(board);
    finished = TRUE;
}

int
main(int argn, char *argv[])
{
    int a[NMAX];
    int i, j, v;
    board_t board;

    for(i = 1; i < DIMENSION + 1; ++i)
        for(j = 1; j < DIMENSION + 1; ++j)
            board.m[i][j] = 0;

    board.freecount = DIMENSION*DIMENSION;

    for(i = 1; i < DIMENSION + 1; ++i)
        for(j = 1; j < DIMENSION + 1; ++j) {
            scanf("%d", &v);
            if(v > 0) fill_square(i, j, v, &board);
        }

    backtrack(a, 0, &board);
    printf("Num calls: %zd\n", num_calls);
}

void
make_move(int a[], int k, data board)
{
    fill_square(board->move[k].x,board->move[k].y,a[k],board);
}
void
unmake_move(int a[], int k, data board)
{
    free_square(board->move[k].x,board->move[k].y,a[k],board);
}
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


