from random import randint

def quicksort(s, l, h):
    if l >= h: return
    p = partition(s, l, h)
    quicksort(s, l, p - 1)
    quicksort(s, p + 1, h)

def partition(s, l, h):
    p = randint(l, h)
    s[p], s[h] = s[h], s[p]
    p = h
    fh =  l
    while l < h:
        if s[l] < s[p]:
            s[l], s[fh] = s[fh], s[l]
            fh += 1
        l += 1
    s[p], s[fh] = s[fh], s[p]
    return fh
