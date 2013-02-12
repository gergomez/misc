#define MAX(a,b) \
       ({ __typeof__ (a) _a = (a); \
               __typeof__ (b) _b = (b); \
             _a > _b ? _a : _b; })
typedef struct tree {
    int item;
    struct tree *parent, *left, *right;
} tree_t;

tree_t *search_tree(tree_t *l, int x);
tree_t *find_minimum(tree_t *t);
tree_t *find_maximum(tree_t *t);
void traverse_tree(tree_t *l);
void empty_tree(tree_t **t);
int height_tree(tree_t *l);
void insert_tree(tree_t **l, int x, tree_t *parent);
int delete_tree(tree_t **l, int x);
