MAXLEN = 100

def get_cost(t, c1 = '\0', c2 = '\0'):
    if t == 'M' : return c1 != c2
    if t == 'I' : return 1
    if t == 'D' : return 1
    if t == 'S' : return 1

def string_compare(s, t):
    m = [[x*(y == 0)+y*(x == 0) for x in xrange(MAXLEN)] for y in xrange(MAXLEN)]
    p = [[0 for x in xrange(MAXLEN)] for x in xrange(MAXLEN)]

    i = 1
    while i < len(s):
        j = 1
        while j < len(t):
            opt = [9999 for c in range(4)]
            opt[0] = m[i-1][j-1] + get_cost('M', s[i], t[j])
            opt[1] = m[i][j-1] + get_cost('I', t[j])
            opt[2] = m[i-1][j] + get_cost('D', s[i])
            if (i > 1 and j > 1) :
                if (s[i-1], s[i]) == (t[j],t[j-1]):
                    opt[3] = m[i-2][j-2] + get_cost('S')

            m[i][j] = opt[0]

            for c in xrange(1,len(opt)):
                if opt[c] < m[i][j]:
                    m[i][j] = opt[c]
                    p[i][j] = c;

            j += 1

        i += 1


    return m[len(s)-1][len(t)-1]
