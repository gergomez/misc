#include<limits.h>
#include<stdlib.h>
#include<stdio.h>


typedef struct llist {
    int item;
    struct llist *next;
} llist_t;

llist_t *search_list(llist_t *l, int x)
{
    for(; l != NULL; l = l->next) {
        if(x == l->item)
            return l;
    }
    return NULL;
}

void insert_list(llist_t **l, int x)
{
    llist_t *p;

    p = malloc(sizeof(llist_t));
    p->item = x;
    p->next = *l;
    *l = p;
}

void traverse_list(llist_t *l)
{
    for(; l != NULL; l = l->next) {
        printf("%d ", l->item);
    }
}

llist_t *predecessor_list(llist_t *l, int x)
{
    if(l == NULL || l->next == NULL)
        return NULL;
    if(l->next->item == x)
        return l;
    else
        return predecessor_list(l->next, x);
}

void delete_list(llist_t **l, int x)
{
    llist_t *p, *t;

    if(NULL == *l)
        return;

    if(x == (*l)->item) {
        t = *l;
        *l = (*l)->next;
        free(t);
    } else {
        p = predecessor_list(*l, x);
        if(p != NULL) {
            t = p->next;
            p->next = p->next->next;
            free(t);
        }
    }
}

llist_t *find_maximum(llist_t *l)
{
    int max = 0;
    llist_t *t = NULL;

    for(; l != NULL; l = l->next) {
        if(l->item > max) {
            max = l->item;
            t = l;
        }
    }
    return t;
}

llist_t *find_minimum(llist_t *l)
{
    int min = INT_MAX;
    llist_t *t = NULL;

    for(; l != NULL; l = l->next) {
        if(l->item < min) {
            min = l->item;
            t = l;
        }
    }
    return t;
}

void empty_list(llist_t **l)
{
    if(*l == NULL) return;

    empty_list(&(*l)->next);
    free(*l);
    *l = NULL;
}

#ifdef TEST
int
main(int argn, char *argv[])
{
    int i, j, n, m;
    llist_t *l = NULL, *p;

    n = atoi(argv[1]);
    m = atoi(argv[2]);

    for(j = 0; j < m; ++j) {
        for(i = 0; i < n; ++i) {
            insert_list(&l, (i+j)); //random());
        }
        for(i = 0; i < n; ++i) {
            traverse_list(l); putchar('\n');
            delete_list(&l, (i+j));
        }
        empty_list(&l);
    }
    return 0;
}
#endif
