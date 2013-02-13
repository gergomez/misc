class pqueue:
    q = []
    def __init__(self, s = []):
#      Naive approach
#        for c in s:
#            self.insert(c)
#
        self.q.extend(s)
        for i in xrange(len(self.q)-1,-1,-1):
            self.bubble_down(i)

    def parent(self, n):
        if len(self.q) == 0:
            return -1
        else:
            return n/2

    def young_child(self, n):
        return 2*n

    def bubble_up(self, p):
        if self.parent(p) == -1:
            return

        m = self.parent(p)

        if self.q[m] > self.q[p]:
            self.q[m], self.q[p] = self.q[p], self.q[m]
            self.bubble_up(m)

    def insert(self, a):
        self.q.append(a)
        self.bubble_up(len(self.q)-1)

    def __init__(self, s = []):
        for c in s:
            self.insert(c)

    def bubble_down(self, p):
        c = self.young_child(p)
        min_index = p

        for i in [0,1]:
            if c+i < len(self.q):
                if self.q[min_index] > self.q[c+i]:
                    min_index = c+i

        if min_index != p:
            self.q[p], self.q[min_index] = self.q[min_index], self.q[p]
            self.bubble_down(min_index)

    def extract_min(self):
        min = self.q[0]
        self.q[0] = self.q[-1]
        del self.q[-1]
        self.bubble_down(0)
        return min

def heapsort(s):
    q = pqueue(s)
    for i in xrange(len(s)):
        s[i] = q.extract_min()
