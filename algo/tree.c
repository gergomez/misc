#include<stdlib.h>
#include<stdio.h>
#include"tree.h"

tree_t *search_tree(tree_t *l, int x)
{
    if (l == NULL) return(NULL);

    if (l->item == x) return(l);

    if (x < l->item)
        return(search_tree(l->left, x));
    else
        return(search_tree(l->right, x));
}

tree_t *find_minimum(tree_t *t)
{
    tree_t *min;

    if (t == NULL) return(NULL);

    min = t;
    while (min->left != NULL)
        min = min->left;
    return(min);
}

tree_t *find_maximum(tree_t *t)
{
    tree_t *max;

    if (t == NULL) return(NULL);

    max = t;
    while (max->right != NULL)
        max = max->right;
    return(max);
}

void traverse_tree(tree_t *l)
{
    if (l != NULL) {
        printf("%d /", l->item);
        traverse_tree(l->left);
        printf("\\");
        traverse_tree(l->right);
    }
}

void empty_tree(tree_t **t)
{
    if(*t == NULL) return;

    empty_tree(&((*t)->left));
    empty_tree(&((*t)->right));
    free(*t);
    *t = NULL;
}

int height_tree(tree_t *l)
{
    if(l == NULL)
        return 0;
    else
        return MAX(height_tree(l->left), height_tree(l->right)) + 1;
}

void insert_tree(tree_t **l, int x, tree_t *parent)
{
    tree_t *p;

    if(*l == NULL) {
        p = malloc(sizeof(tree_t));
        p->item = x;
        p->left = p->right = NULL;
        p->parent = parent;
        *l = p;
        return;
    }

    if (x < (*l)->item)
        insert_tree(&((*l)->left), x, *l);
    else
        insert_tree(&((*l)->right), x, *l);
}

int delete_tree(tree_t **l, int x)
{
    if((*l) == NULL) return 0;

    if(x == (*l)->item) {
        if((*l)->left != NULL && (*l)->right != NULL) {
            tree_t *t = find_maximum((*l)->left);
            (*l)->item = t->item;
            delete_tree(&t, t->item);
        } else {
            tree_t *t;
            if((*l)->left != NULL) {
                t = (*l)->left;
            } else {
                t = (*l)->right;
            }

            if(t != NULL)
                t->parent = (*l)->parent;

            if((*l)->parent) {
                if((*l)->parent->left == (*l))
                    (*l)->parent->left = t;
                else
                    (*l)->parent->right = t;
                free(*l);
            } else {
                free(*l);
                *l = t;
            }
        }
        return 1;
    } else if(x < (*l)->item) {
        delete_tree(&((*l)->left), x);
    } else {
        delete_tree(&((*l)->right), x);
    }
    return 0;
}

int
main(int argn, char *argv[])
{
    int i, j, n, m, avg = 0;
    tree_t *t = NULL;

    n = atoi(argv[1]);
    m = atoi(argv[2]);

    for(j = 0; j < m; ++j) {
        for(i = 0; i < n; ++i) {
            insert_tree(&t, random(), NULL);
        }
        avg += height_tree(t);
        empty_tree(&t);
    }
    printf("%f\n", 1.*avg/m);
    return 0;
}
