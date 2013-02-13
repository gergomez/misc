import sys

def knapsack(size, weight, value, itemUsed):
    maxValues = [0]*(size+1)
    for s in range(size + 1):
        maxValue = 0
        newItem = 0
        for j in [i for i in range(len(weight)) if weight[i] <= s]:
            if maxValues[s-weight[j]] + value[j] > maxValue:
                maxValue = maxValues[s-weight[j]] + value[j]
                newItem = j
        maxValues[s] = maxValue
        itemUsed[s] = newItem
    return maxValues[size]

def printUsed(size, weight, value, itemUsed):
    while size > 0:
        print itemUsed[size] + 1
        size -= weight[itemUsed[size]]

weight = []
value = []

for line in open('knapsack.txt'):
    parts = line.rstrip().split('\t')
    weight.append(int(parts[1]))
    value.append(int(parts[2]))

size = int(sys.argv[1])
itemUsed = [0]*(size+1);
print knapsack(size, weight, value, itemUsed)
printUsed(size, weight, value, itemUsed)
