typedef struct llist {
    int item;
    struct llist *next;
} llist_t;

llist_t *search_list(llist_t *l, int x);
void insert_list(llist_t **l, int x);
void traverse_list(llist_t *l);
llist_t *predecessor_list(llist_t *l, int x);
void delete_list(llist_t **l, int x);
llist_t *find_maximum(llist_t *l);
llist_t *find_minimum(llist_t *l);
void empty_list(llist_t **l);
