#include<stdio.h>

int *f1(int n) {
    static int i[3] = {1, 2, 3};
    return &i[n];
}

int *f2(int n) {
    static int i[3] = {11, 12, 13};
    return &i[n];
}

int *(*f(int n))(int) {
    int *(*a[])(int) = {f1, f2};
    return a[n];
}

int main() {
    int *(*fp)(int) = f(1);
    printf("%d\n", *fp(2));
    return 0;
}
