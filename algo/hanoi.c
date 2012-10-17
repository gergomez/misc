#include<stdio.h>

int pegs[3];

void
show(void)
{
    int i;
    for(i = 0; i < 3; ++i) {
        printf("%d ", pegs[i]);
    }
}

void
solve(int from, int to, int n)
{
    int tmp;

    if(0 == n) {
        return;
    }
    tmp = 3 - from - to;
    solve(from, tmp, n - 1);
    show();
    printf(" | %d -> %d\n", from + 1, to + 1);
    --pegs[from];
    ++pegs[to];
    solve(tmp, to, n - 1);
}

int
main(int argn, char *argc[])
{
    scanf("%d", &pegs[0]);
    solve(0, 2, pegs[0]);
    show();
    printf("\nSOLVED!\n");
}
