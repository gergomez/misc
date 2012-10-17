#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <limits.h>

#define HUMAN	0
#define MAXM	100	
#define MAXN	100
#define MAXLINE	1024

int N, M;	/* N Elementos tomados de M en M */
int dat[MAXM][MAXN];
int inf[MAXM][MAXN];

void semilla(int *p);
char *showit(int *p);
int parse(int *p, char *s);
int intcmp(int *a, int *b);
void intcpy(int *a, int *b);
void check(int *a, int *b, int *c, int *d, int *m, int *h);
int minp(int *p, int n);
int maxp(int *p, int n);
int nextperm(int *p);
int checkprob(int *p);
int checkinfo(int *p);

int
main(int argn, char *argv[])
{
    char ibuf[MAXLINE];
    int  pdat[MAXN];
    int  mio[MAXM];
    int  adiv[MAXM], test[MAXM], best[MAXM];
    int  i, j, paso, flag;
    int  m, h;		/* Muetos, heridos */
    int  maskm[MAXM];
    int  maskh[MAXM];
    int  prob, info;
    int  mprob, minfo;

    if(argn < 3) {
	fprintf(stderr, "mastermind n m\nn elementos tomados de m en m\n");
	exit(1);
    }

    N = atoi(argv[1]);
    M = atoi(argv[2]);

    if(N < 1 || N >= MAXN || M < 1 || M >= MAXM) {
	fprintf(stderr, "Dimensiones del problema demasiado grandes.\n");
	exit(1);
    }
	
    for(i = 0; i < M; ++i) {
	for(j = 0; j < N; ++j) {
	    dat[i][j] = 1;
	    inf[i][j] = 0;
	}
    }

    if(argn > 3) {
	while(fgets(ibuf, MAXLINE, stdin) != NULL) { 
	    if(!parse(mio, ibuf)) 
		break; 
	    fprintf(stderr, "Combinacion invalida\n"); 
	}
    }
    else 
	semilla(mio);
    printf("%s\n", showit(mio));
#if HUMAN
    while(fgets(ibuf, MAXLINE, stdin) != NULL) {
	if(parse(adiv, ibuf)) {
	    fprintf(stderr, "Combinacion invalida\n"); 
	    continue;
	}
#else
    for(paso = 0; paso < 10; ++paso) {
        semilla(adiv);
	if(paso > 0) {
	intcpy(test, adiv);
	nextperm(test);
	for(flag = 1, mprob = 0, minfo = 2*M; 
	    !intcmp(test, adiv) && flag; 
	    nextperm(test)) { 
	    printf("[%d]: %s : %d %d\n", paso, showit(test), prob, info);
	    if(!(prob = checkprob(test)))  {
		flag = 0;
		continue; 
	    }
	    flag = 1;
	    info = checkinfo(test);
	    if(info < minfo) {
		intcpy(best, test);
		minfo = info;
	    } else if (info == minfo) {
		if(mprob < prob) {
		    intcpy(best, test);
		    mprob = prob;
		}
	    }
	}
	printf("[%d]: %s %d %d", paso, showit(best), mprob, minfo);
	intcpy(adiv, best);
	}
	else printf("[%d]: %s", paso, showit(adiv));
#endif

	check(mio, adiv, maskm, maskh, &m, &h);
	printf("     %d %d\n", m, h);
	if(m == M) {
	    fprintf(stderr, "Fin.\n");
	    exit(0);
	}

	for(j = 0; j < M; ++j) { 
	    ++inf[j][adiv[j]];
	    if(!m) { 
		for(i = 0; i < M; ++i)  { 
		    if(dat[i][adiv[j]]) 
			dat[i][adiv[j]] += h + m; 
		} 
		dat[j][adiv[j]] = 0 ;
	    } else if (!h) {
		dat[i][adiv[j]] += m;
	    }
	} 

        putchar('\n');
	for(i = 0; i < M; ++i) {
	    for(j = 0; j < N; ++j)
		printf("%d(%d) ", inf[i][j], dat[i][j]);
	    putchar('\n');
	}
        putchar('\n');
	
    }
		
}

void
semilla(int *p)
{
    int i;

    for(i = 0; i < M; ++i)
	p[i] = 1.0*N*rand()/RAND_MAX;
}

char *
showit(int *p)
{
    int i, j;
    static char *buf = NULL;
    char *s;

    if(buf == NULL)
	buf = malloc(sizeof(char)*(M*(N%10+2)+1));

    s = buf;
    for(i = 0; i < M; ++i) {
	sprintf(s, "%d %n", p[i],&j);
	s += j;
    }
    *s = '\0';
    return buf;
}

int
parse(int *p, char *s)
{
    int i, j;

    for(i = 0; i < M; ++i) { 
	sscanf(s, "%d%n", &p[i], &j); 
	if(p[i] >= N || p[i] < 0) { 
	    return 1;
	} 
	s += j;
    }
    return 0;
}

int
intcmp(int *a, int *b)
{
    int i;

    for(i = 0; i < M; ++i)
	if(*a++ != *b++)
	    return 0;
    return 1;
}

void
intcpy(int *a, int *b)
{
    int i;

    for(i = 0; i < M; ++i)
	*a++ = *b++;
}


void
check(int *a, int *b, int *c, int *d, int *m, int *h)
{
    int i, j;

    *m = *h = 0;
    for(i = 0; i < M; ++i) {
	d[i] = -1;
	if(a[i] == b[i]) {
	    ++*m;
	    c[i] = 1;
	}
	else c[i] = 0;
    }

    for(i = 0; i < M; ++i) {
        if(c[i])
	    continue;
	for(j = 0; j < M; ++j) {
	    if(c[j])
		continue;
	    if(a[i] == b[j]) {
		++*h;
		d[i] = j;
		break;
	    }
	}
    }
}

int 
minp(int *p, int n)
{
    int i, j, k;

    k = INT_MAX;
    for(i = 0; i < n; ++i)
	if(p[i] < k) {
	    k = p[i];
	    j = i;
	}
    return j;
}

int 
maxp(int *p, int n)
{
    int i, j, k;

    k = 0;
    for(i = 0; i < n; ++i)
	if(p[i] > k) {
	    k = p[i];
	    j = i;
	}
    return j;
}

int
nextperm(int *p)
{
    int i;
    
    for(i = 0; i < M && ++p[i] >= N; ++i) 
	p[i] = 0;
    return (i >= M);
}

int
checkprob(int *p)
{
    int i, j;

    for(j = 0, i = 0; i < M; ++i) {
	if(dat[i][p[i]] == 0)
	    return 0;
	j += dat[i][p[i]];
    }
    return j;
}

int
checkinfo(int *p)
{
    int i, j;

    for(j = 0, i = 0; i < M; ++i) {
	j += inf[i][p[i]];
    }
    return j;
}
