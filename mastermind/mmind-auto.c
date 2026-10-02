#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#define HUMAN 0
#define MAXPLYS 1000
#define MAXN 100
#define MAXM 100
#define MAXLINE 1024
#define DEBUG 0
#define LHMAX 3

int N, M;

void semilla(int *p);
char *showit(int *p);
int parse(int *p, char *s);
int intcmp(int *a, int *b);
void intcpy(int *a, int *b);
void check(int *a, int *b, int *c, int *d, int *m, int *h);
void lowfrand(int *p, int *freq);
int nextperm(int *p);
int nextperm_mask(int *p, int *mask);

int main(int argn, char *argv[])
{
    int paso, valido;    /* Contador de paso y flag */
    int m, h;            /* Muetos, heridos */
    int *num;            /* Numeros jugados */
    char ibuf[MAXLINE];  /* Entrada de usuario */
    int *mask, *freq;    /* Mascara de posibles */
    int *maskm, *maskh;  /* Mascara de muertos y heridos */
    int i, j, k, *p, *q; /* Entereos y punteros genericos */
    int lh, d, cerca;    /* Ultimos heridos == 0 y distancia */

    srand(time(NULL));
    if (argn < 3) {
        fprintf(stderr, "mastermind n m\nn elementos tomados de m en m\n");
        exit(1);
    }

    N = atoi(argv[1]);
    M = atoi(argv[2]);

    if (N < 1 || N >= MAXN || M < 1 || M >= MAXM) {
        fprintf(stderr, "Dimensiones del problema fuera de los limites.\n");
        exit(1);
    }
    num = (int *)malloc(sizeof(int) * (M + 2) * MAXPLYS);
    mask = (int *)malloc(sizeof(int) * M * N);
    maskm = (int *)malloc(sizeof(int) * M);
    maskh = (int *)malloc(sizeof(int) * M);
    freq = (int *)malloc(sizeof(int) * N);
    if (num == NULL || maskm == NULL || maskh == NULL || mask == NULL ||
        freq == NULL) {
        fprintf(stderr, "Memoria agotada.\n");
        exit(1);
    }

    if (argn > 3) {
        while (fgets(ibuf, MAXLINE, stdin) != NULL) {
            if (!parse(num, ibuf)) break;
            fprintf(stderr, "Combinacion invalida\n");
        }
    } else
        semilla(num);

    printf("%s\n", showit(num));

    *(num + M) = 0;
    *(num + M + 1) = 0;
    for (i = 0; i < N; ++i) {
        freq[i] = 0;
        for (j = 0; j < M; ++j) *(mask + i * M + j) = 1;
    }
    lh = 0;
    d = M;
    cerca = 0;
    for (paso = 1; paso < MAXPLYS; ++paso) {
        p = (num + paso * (M + 2));
        valido = 0;
        semilla(p);
        j = 0;
        while (!valido) {
            valido = 1;
            if (!cerca && (lh >= LHMAX || (paso > 1 && paso < N / M + 1))) {
                lowfrand(p, freq);
            } else if (!cerca && (rand() % (M * paso) == 0)) {
                semilla(p);
            } else {
                nextperm_mask(p, mask);
            }
            ++j;
            if (j % 1000000 == 0) write(1, ".", 1);
            for (i = 1; i < paso; ++i) {
                q = (num + i * (M + 2));
                if ((d = intcmp(p, q)) == 0) {
                    valido = 0;
                    break;
                }
                if (cerca || (lh < LHMAX && paso > N / M)) {
                    check(q, p, maskm, maskh, &m, &h);
                    if (m != *(q + M) || h != *(q + M + 1)) {
                        valido = 0;
                        break;
                    }
                }
            }
            if (lh >= LHMAX) lh = 0;
        }
        check(num, p, maskm, maskh, &m, &h);
        *(p + M) = m;
        *(p + M + 1) = h;

        printf("%s : %d %d (%d)\n", showit(p), m, h, j);

        if (m == M) break;

        if (d < 2 || (paso < M - 2 && h == 0)) {
            ++lh;
        }
        if ((m + h) == M) {
            cerca = 1; /* Modo cercano */
            printf("Modo CERCANO: ON\n");
            for (i = 0; i < N; ++i) {
                k = 0;
                for (j = 0; j < M; ++j)
                    if (*(p + j) == i) {
                        k = M;
                        break;
                    }
                for (; k < M; ++k) *(mask + k * N + i) = 0;
            }
        }

        if (m == 0) {
            if (h == 0) {
                for (i = 0; i < M; ++i)
                    for (j = 0; j < M; ++j) *(mask + i * N + *(p + j)) = 0;
            } else {
                for (i = 0; i < M; ++i) *(mask + i * N + *(p + i)) = 0;
            }
        }
        for (i = 0; i < M; ++i) freq[*(p + i)]++;
    }
    printf("Pasos: %d\n", paso);
    putchar('\n');
    return 0;
}

void semilla(int *p)
{
    int i;

    for (i = 0; i < M; ++i) p[i] = 1.0 * N * rand() / RAND_MAX;
}

char *showit(int *p)
{
    int i, j;
    static char *buf = NULL;
    char *s;

    if (buf == NULL) buf = malloc(sizeof(char) * (M * (N % 10 + 2) + 1));

    s = buf;
    for (i = 0; i < M; ++i) {
        sprintf(s, "%d %n", p[i], &j);
        s += j;
    }
    *s = '\0';
    return buf;
}

int parse(int *p, char *s)
{
    int i, j;

    for (i = 0; i < M; ++i) {
        sscanf(s, "%d%n", &p[i], &j);
        if (p[i] >= N || p[i] < 0) {
            return 1;
        }
        s += j;
    }
    return 0;
}

int intcmp(int *a, int *b)
{
    int i, d;

    for (d = 0, i = 0; i < M; ++i)
        if (*a++ != *b++) ++d;
    return d;
}

void check(int *a, int *b, int *c, int *d, int *m, int *h)
{
    int i, j;

    *m = *h = 0;
    for (i = 0; i < M; ++i) {
        d[i] = -1;
        if (a[i] == b[i]) {
            ++*m;
            c[i] = 1;
        } else
            c[i] = 0;
    }

    for (i = 0; i < M; ++i)
        for (j = 0; !c[i] && j < M; ++j) {
            if (c[j] || d[j] != -1) continue;
            if (a[i] == b[j]) {
                ++*h;
                d[j] = i;
                break;
            }
        }
}

void lowfrand(int *p, int *freq)
{
    int i, j, k, maxf, r;

    for (maxf = 0, i = 0; i < N; ++i)
        if (freq[i] > maxf) maxf = freq[i];
    for (i = 0; i < M; ++i) {
        r = rand() % maxf + 1;
        k = rand() % N;
        for (j = k; j < 2 * N; ++j)
            if (r >= freq[j % N]) {
                p[i] = j % N;
                freq[i]++;
                break;
            }
    }
}

int nextperm(int *p)
{
    int i;

    for (i = 0; i < M && ++p[i] >= N; ++i) p[i] = 0;
    return !(i < M);
}

int nextperm_mask(int *p, int *m)
{
    int i, k;

    for (i = 0; i < M; ++i) {
        k = 0;
        ++p[i];
        if (p[i] >= N) {
            p[i] = 0;
            ++k;
        }
        while (!*(m + i * N + p[i])) {
            ++p[i];
            if (p[i] >= N) {
                p[i] = 0;
                ++k;
                if (k > 1) return k;
            }
        }
        if (!k) break;
    }
    return 0;
}
