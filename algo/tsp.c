#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define MAXLINE 4096
#define INITIAL_TEMPERATURE 100.0
#define COOLING_FRACTION .98
#define COOLING_STEPS 1000
#define STEPS_PER_TEMP 10000
#define K 0.01

#define MAXN 64

typedef struct {
    char *names[MAXN];
    int m[MAXN][MAXN];
    int n;
} tsp_data_t;

typedef struct {
    int s[MAXN];
    int cost;
} tsp_solution_t;

int
read_tsp_data(tsp_data_t *tsp)
{
    char buf[MAXLINE];
    char *word;
    int i, n;

    if(fgets(buf, MAXLINE, stdin) == NULL) return -1;

    buf[strlen(buf)-1] = '\0';
    for (i = 0, word = strtok(buf, ","); word != NULL && i < MAXN; word = strtok(NULL, ",")) {
        tsp->names[i++] = strdup(word);
    }

    tsp->n = i;

    n = 0;
    while(fgets(buf, MAXLINE, stdin) != NULL && n < tsp->n) {
        buf[strlen(buf)-1] = '\0';
        for (i = 0, word = strtok(buf, ","); word != NULL && i < tsp->n; word = strtok(NULL, ",")) {
            tsp->m[n][i++] = atoi(word);
        }
        ++n;
    }
    if(n < tsp->n) {
        fprintf(stdout, "Warning: Not enough data\n");
        tsp->n = n;
    }
    return 0;
}

void
print_solution(tsp_data_t *t, tsp_solution_t *s)
{
    int i;

    printf("%d:%s(%d)", s->cost, t->names[s->s[0]],t->m[s->s[t->n-1]][s->s[0]]);
    for(i = 1; i < t->n; ++i) {
        printf(">%s(%d)", t->names[s->s[i]], t->m[s->s[i-1]][s->s[i]]);
    }
    printf("\n");
}

int
solution_cost(tsp_data_t *t, tsp_solution_t *s)
{
    return s->cost;
}

void
initialize_solution(tsp_data_t *t, tsp_solution_t *s)
{
    int i;
    s->cost = t->m[t->n-1][0];
    s->s[0] = 0;
    for (i = 1; i < t->n; ++i) {
        s->s[i] = i;
        s->cost += t->m[i-1][i];
    }
}

int
transition(tsp_data_t *t, tsp_solution_t *s, int i1, int i2)
{
    int cost = 0;

    int pi1,ni1,pi2,ni2,vi1,vi2;

    if(i1 == i2) return 0;

    pi1 = i1 > 0 ? s->s[i1 - 1] : s->s[t->n-1];
    vi1 = s->s[i1];
    ni1 = s->s[(i1 + 1)%t->n];

    pi2 = i2 > 0 ? s->s[i2 - 1] : s->s[t->n-1];
    vi2 = s->s[i2];
    ni2 = s->s[(i2 + 1)%t->n];

    /* Cost of removing pi1->vi1->ni1 */
    cost -= t->m[pi1][vi1] + t->m[vi1][ni1];
    /* Cost of removing pi2->vi2->ni2 */
    cost -= t->m[pi2][vi2] + t->m[vi2][ni2];

    /* Cost of adding pi2->vi1->ni2 */
    cost += t->m[pi2][vi1] + t->m[vi1][ni2];
    /* Cost of adding pi1->vi2->ni1 */
    cost += t->m[pi1][vi2] + t->m[vi2][ni1];

    /* Check if swapping consecutive vertex, in that case
     * we need to add twice the vi1-vi2 distance (as we remove it
     * twice) */

    if( pi1 == vi2 || ni1 == vi2 || pi2 == vi1 || ni2 == vi1) {
        cost += t->m[vi1][vi2] + t->m[vi2][vi1];
    }

    s->cost += cost;
    s->s[i1] = vi2;
    s->s[i2] = vi1;
    return cost;
}

double
random_float(double a, double b)
{
    b = (b-a)*random()/((unsigned int)(2L<<31)-1);
    return a + b;
}

int
random_int(int a, int b)
{
    b = random()%(b-a);
    return a + b;
}

void
random_sampling(tsp_data_t *t, tsp_solution_t *s)
{
    int i1, i2;
    int i, j;
    int value;
    int delta;

    initialize_solution(t, s);
    value = solution_cost(t, s);

    for (i = 0; i < COOLING_STEPS; ++i) {
        for (j = 0; j < STEPS_PER_TEMP; ++j) {
            i1 = random_int(0, t->n);
            i2 = random_int(0, t->n);
            delta = transition(t, s, i1, i2);
            if (delta < 0) { /* ACCEPT-WIN */
                value =  value+delta;
            } else {
                transition(t, s, i2, i1);
            }
        }
    }
}

void
anneal(tsp_data_t *t, tsp_solution_t *s)
{
    int i1, i2;
    int i, j;
    int value;
    int start_value;
    double temp;
    double delta;
    double merit, flip;
    double exponent;

    temp = INITIAL_TEMPERATURE;
    initialize_solution(t, s);
    value = solution_cost(t, s);

    for (i = 0; i < COOLING_STEPS; ++i) {
        temp *= COOLING_FRACTION;

        start_value = value;
        for (j = 0; j < STEPS_PER_TEMP; ++j) {
            i1 = random_int(0, t->n);
            i2 = random_int(0, t->n);
            delta = transition(t, s, i1, i2);

            if(delta == 0) {
                continue;
            }

            flip = random_float(0, 1);
            exponent = (-1.0*delta/value)/(K*temp);
            merit = pow(M_E, exponent);

            if (delta < 0) { /* ACCEPT-WIN */
                value =  value+delta;
            } else {         /* ACCEPT-LOSS */
                if (merit > flip) {
                    value = value + delta;
                } else {        /* REJECT */
                    transition(t, s, i2, i1);
                }
            }
        }

        if ((value - start_value) < 0.0) {
            temp = temp/COOLING_FRACTION;
        }
    }
}

int
main(int argn, char *argv[])
{
    tsp_data_t tsp;
    tsp_solution_t sol;
    int i, j;

    srandom(time(NULL));
    read_tsp_data(&tsp);
    initialize_solution(&tsp, &sol);
/*
    print_solution(&tsp, &sol);
    transition(&tsp, &sol, 0, 1);
    print_solution(&tsp, &sol);
    transition(&tsp, &sol, 0, 1);
    print_solution(&tsp, &sol);
*/

    anneal(&tsp, &sol);
    //random_sampling(&tsp, &sol);
    print_solution(&tsp, &sol);
}
