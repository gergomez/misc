#include<stdio.h>

#define MAXPEGS 10

int pegs[MAXPEGS];
int npegs;
long basevec;

void
show(void)
{
    int i;
    for(i = 0; i < npegs; ++i) {
        printf("%2d ", pegs[i]);
    }
}

void
solve(int from, int to, int n)
{
    int i;
    long vec = basevec;

    if(0 == n) {
        return;
    }

    vec |= (1 << from);
    vec |= (1 << to);
    vec = ~vec;
    for(i = 0; i < npegs; ++i) {
        if((vec & (1 << i))) {
                break;
        }
    }
    solve(from, i, n - 1);
    show();
    printf(" | %d -> %d (%d)\n", from, to, i);
    --pegs[from];
    ++pegs[to];
    solve(i, to, n - 1);
}

int
main(int argn, char *argc[])
{
    int i, n, m;
    scanf("%d %d", &n, &npegs);
    if(npegs > MAXPEGS) {
        printf("ERROR: npegs should not be greater than %d\n", MAXPEGS);
        return 1;
    }

    pegs[0] = n;
    basevec = 0;
    if(npegs > 3) {
        m = npegs - 2;
        if(n/m < 1) { m = n; }
        for (i = 2; i < m + 1; ++i) {
            solve(0, i, n/m);
            basevec |= (1 << i);
        }
        printf("\n");
        solve(0, npegs - 1, n - (n/m)*(m - 1));
        printf("\n");
        for (i = m; i > 1; --i) {
            basevec &= ~(1 << i);
            solve(i, npegs - 1, n/m);
        }
    } else {
        solve(0, npegs - 1, n);
    }
    show();
    printf("\nSOLVED!\n");
}
