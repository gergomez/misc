def mergesort(s, l, h):
    if l >= h: return
    m = (l+h - 1)/2
    mergesort(s, l, m)
    mergesort(s, m + 1, h)
    merge(s, l, m, h)

def merge(s, l, m, h):
    s1 = s[l:m+1]
    s1l = m - l + 1
    s2 = s[m+1:h+1]
    s2l = h - m
    j = k = 0
    i = l
    while j < s1l and k < s2l :
        if s1[j] < s2[k]:
            s[i] = s1[j]
            j += 1
        else:
            s[i] = s2[k]
            k += 1
        i += 1
    while j < s1l:
        s[i] = s1[j]
        i += 1
        j += 1

    while k < s2l:
        s[i] = s2[k]
        i += 1
        k += 1
