def parCheckG(s):
    sList = ['{','(','[','"',"'"]
    eList = ['}',')',']','"',"'"]
    stack = []
    for c in s:
        if c in sList: stack.append(c)
        elif c in eList:
            try:
                if stack.pop() != sList[eList.index(c)]: return False
            except IndexError:
                return False
    return True

def parCheck(s):
    n=0
    for c in s:
        if c == '(': n += 1
        elif c == ')': n -= 1
    return n == 0

def infix2postfix(s):
    st = []
    lo = ''
    prec = {}
    prec['^'] = 4
    prec['*'] = prec['/'] = 3
    prec['+'] = prec['-'] = 2
    prec['('] = 1
    for c in s:
        if c in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' or c in '0123456789':
            lo += c
        elif c in '*/+-^':
            while st and prec[st[-1]] >= prec[c]:
                lo += st.pop()
            st.append(c)
        elif c == ')':
            try:
                while st[-1] != '(':
                    lo += st.pop()
            except IndexError: return 'Unbalanced ()'
            st.pop()
        elif c == '(':
                st.append(c)
    while st:
        if st[-1] == '(' : return 'Unbalanced ()'
        lo += st.pop()
    return lo

def evalPostfix(s):
    def calc(op, op1, op2):
        if op == '*':
            return op1*op2
        elif op == '/':
            return op1/op2
        elif op == '+':
            return op1+op2
        elif op == '-':
            return op1-op2
        elif op == '^':
            return op1**op2
    st = []
    try:
        for c in s:
            if c in '0123456789':
                st.append(int(c))
            else:
                op1 = st.pop()
                op2 = st.pop()
                st.append(calc(c, op1, op2))
        return st.pop()
    except IndexError: return 'Invalid postfix!'

def recMC(cL, change):
    minCoins = change
    if change in cL:
        return 1
    else:
        for i in [c for c in cL if c<= change]:
            numCoins = 1 + recMC(cL, change - i)
            if numCoins < minCoins:
                minCoins = numCoins
    return minCoins

def recDC(cL, change, known = {}):
    minCoins = change
    if change in cL:
        known[change] = 1
        return 1
    elif change in known:
        return known[change]
    else:
        for i in [c for c in cL if c<= change]:
            numCoins = 1 + recDC(cL, change - i, known)
            if numCoins < minCoins:
                minCoins = numCoins
                known[change] = minCoins
    return minCoins

def dpMakeChange(coinValueList, change, coinsUsed):
    minCoins = [0]*(change+1)
    for cents in range(change+1):
        coinCount = cents
        newCoin = 1
        for j in [c for c in coinValueList if c <= cents]:
            if minCoins[cents-j] + 1 < coinCount:
                coinCount = minCoins[cents-j]+1
                newCoin = j
        minCoins[cents] = coinCount
        coinsUsed[cents] = newCoin
    return minCoins[change]

def printCoins(coinsUsed, change):
    coin = change
    while coin > 0:
        thisCoin = coinsUsed[coin]
        print thisCoin
        coin = coin - thisCoin
