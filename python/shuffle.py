from random import randint

def shuffle(l):
    i = len(l) - 1
    while i > 0:
        t = randint(0, i)
        l[t], l[i] = l[i], l[t]
        i -= 1
