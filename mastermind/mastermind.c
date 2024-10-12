#include <arpa/inet.h>
#include <netdb.h>
#include <netinet/in.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <time.h>
#include <unistd.h>

#define HUMAN 0
#define MAXPLYS 1000
#define MAXN 100
#define MAXM 100
#define BUFSIZE 16384
#define MAXITER 3000
#define LHMAX 3

int N, M;

char *version = "MasterMind 0.1\n";
char *error = "ERROR\n";
char *trampa = "HAS HECHO TRAMPA\n";
char *outofres = "RECURSOS AGOTADOS\n";
char *errdim = "DIMENSIONES ERRONEAS\n";
char *youwin = "GANASTE\n";
char *Iwin = "GANE\n";
char *empate = "EMPATE\n";

void semilla(int *p);
char *showit(int *p);
int parse(int *p, char *s);
int intcmp(int *a, int *b);
void intcpy(int *a, int *b);
void check(int *a, int *b, int *c, int *d, int *m, int *h);
void lowfrand(int *p, int *freq);
int nextperm_mask(int *p, int *mask);
int mastermind(int empieza);

int sock_desc_t;
char buf[BUFSIZE];

int main(int argn, char *argv[])
{
    int l, q = 1;
    struct sockaddr_in s_in;
    struct sockaddr_in p_in;
    int sock_desc;
    socklen_t add_size;

    srand(time(NULL));

    if (argn < 2) {
        fprintf(stderr, "mastermind <puerto>\n");
        exit(1);
    }

    sock_desc = socket(AF_INET, SOCK_STREAM, 0);
    if (sock_desc == -1) {
        perror("socket()");
        exit(1);
    }

    memset(&s_in, 0, sizeof(s_in));
    s_in.sin_family = AF_INET;
    s_in.sin_addr.s_addr = INADDR_ANY;
    s_in.sin_port = htons(atoi(argv[1]));

    if (bind(sock_desc, (struct sockaddr *)&s_in, sizeof(s_in)) == -1) {
        perror("bind()");
        exit(1);
    }
    if (listen(sock_desc, 4) == -1) {
        perror("listen()");
        exit(1);
    }
    signal(SIGCHLD, SIG_IGN); /* Ignore childrens ... let them die alone */
    printf("Server running...\n");
    while (1) {
        memset(&p_in, 0, sizeof(p_in));
        sock_desc_t = accept(sock_desc, (struct sockaddr *)&p_in, &add_size);
        if (sock_desc_t == -1) {
            perror("accept()");
            exit(1);
        }

        printf("Conexion desde %s\n", inet_ntoa(p_in.sin_addr));

        send(sock_desc_t, version, strlen(version), 0);
        while ((l = recv(sock_desc_t, buf, BUFSIZE, 0)) > 0) {
            buf[l] = 0;
            if (!strncasecmp("QUIT", buf, 4)) {
                close(sock_desc_t);
                printf("Conexion desde %s finalizada\n",
                       inet_ntoa(p_in.sin_addr));
                break;
            }
            if ((sscanf(buf, "%d %d %d", &N, &M, &q) < 3) || N < 1 ||
                N >= MAXN || M < 1 || M >= MAXM) {
                send(sock_desc_t, errdim, strlen(errdim), 0);
                continue;
            }
            if (fork() == 0) { /* Estamos en el hijo */
                mastermind(q);
                close(sock_desc_t);
                printf("Conexion desde %s finalizada\n",
                       inet_ntoa(p_in.sin_addr));
                return 0;
            }
            close(sock_desc_t); /* Ya lo tiene abierto el hijo, el padre debe
                                   cerrarla */
            break;
        }
    }
    return 0;
}

int mastermind(int empieza)
{
    int paso, valido;    /* Contador de paso y flag */
    int m, h;            /* Muetos, heridos */
    int *com;            /* Numeros jugados por el ordenador*/
    int *hum;            /* Numeros jugados por el humano */
    int *mask, *freq;    /* Mascara de posibles */
    int *maskm, *maskh;  /* Mascara de muertos y heridos */
    int i, j, k, *p, *q; /* Entereos y punteros genericos */
    int lh, d, cerca;    /* Ultimos heridos == 0 y distancia */
    int vuelta;

    com = (int *)malloc(sizeof(int) * (M + 2) * MAXPLYS);
    hum = (int *)malloc(sizeof(int) * (M + 2) * MAXPLYS);
    mask = (int *)malloc(sizeof(int) * M * N);
    maskm = (int *)malloc(sizeof(int) * M);
    maskh = (int *)malloc(sizeof(int) * M);
    freq = (int *)malloc(sizeof(int) * N);

    if (com == NULL || hum == NULL || maskm == NULL || maskh == NULL ||
        mask == NULL || freq == NULL) {
        send(sock_desc_t, outofres, strlen(outofres), 0);
        return 1;
    }

    semilla(com);
    if (!empieza) {
        while ((i = recv(sock_desc_t, buf, BUFSIZE, 0)) > 0) {
            buf[i] = 0;
            if (!parse(hum, buf)) break;
            send(sock_desc_t, error, strlen(error), 0);
        }
    }
    *(hum + M) = 0;
    *(hum + M + 1) = 0;
    for (i = 0; i < N; ++i) {
        freq[i] = 0;
        for (j = 0; j < M; ++j) *(mask + i * M + j) = 1;
    }
    lh = 0;
    d = M;
    cerca = 0;
    for (paso = 1; paso < MAXPLYS; ++paso) {
        p = (com + paso * (M + 2));
        valido = 0;
        semilla(p);
        j = 0;
        vuelta = 0;
        while (!valido) {
            int iteracion = 0;

            valido = 1;
            if (!cerca && (lh >= LHMAX || (paso > 1 && paso < N / M + 1))) {
                lowfrand(p, freq);
            } else if (!cerca && !vuelta && (rand() % (M * paso) == 0)) {
                semilla(p);
            } else {
                vuelta += nextperm_mask(p, mask);
                if (vuelta > 1) {
                    send(sock_desc_t, trampa, strlen(trampa), 0);
                    goto fin;
                }
            }

            if (++iteracion > MAXITER) {
                break;
            }
            for (i = 1; i < paso; ++i) {
                q = (com + i * (M + 2));
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

        q = hum + (paso - 1) * (M + 2);
        if (paso > 1 || !empieza) {
            check(com, q, maskm, maskh, &m, &h);
            sprintf(buf, "%d %d : %s\n", m, h, showit(p));
            send(sock_desc_t, buf, strlen(buf), 0);
            *(q + M) = m;
            *(q + M + 1) = h;
            if (m == M) {
                send(sock_desc_t, youwin, strlen(youwin), 0);
                printf("PERDEDOR\n");
                goto fin;
            }
        } else {
            sprintf(buf, "%s\n", showit(p));
            send(sock_desc_t, buf, strlen(buf), 0);
        }

        for (;;) {
            i = recv(sock_desc_t, buf, BUFSIZE, 0);
            if (i == 0) goto fin;
            buf[i] = 0;
            sscanf(buf, "%d %d : %n", &m, &h, &i);
            if (m < 0 || m > M || h < 0 || h > M || (h + m) > M ||
                parse(q + (M + 2), &buf[i]))
                send(sock_desc_t, error, strlen(error), 0);
            else
                break;
        }

        if (m == M) {
            check(com, q, maskm, maskh, &m, &h);
            if (empieza && m == M) {
                send(sock_desc_t, empate, strlen(empate), 0);
            } else {
                char buf[BUFSIZE];
                sprintf(buf, "%d %d : ( %s) %s", m, h, showit(com), Iwin);
                send(sock_desc_t, buf, strlen(buf), 0);
                printf("GANADOR\n");
            }
            goto fin;
        }

        *(p + M) = m;
        *(p + M + 1) = h;
        if (d < 2 || (paso < M - 2 && h == 0)) {
            ++lh;
        }
        if ((m + h) == M) {
            cerca = 1; /* Modo cercano */
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
fin:
    free(com);
    free(hum);
    free(mask);
    free(maskm);
    free(maskh);
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
        if (j == 0 || p[i] >= N || p[i] < 0) {
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
