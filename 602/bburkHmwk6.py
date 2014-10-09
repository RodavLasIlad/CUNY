import numpy as np
import random
L = random.sample(range(0,10000), 10000)
random.L = random.choice(L)

# My original sort function
def sortWithLoops():
    # I make a copy of L in each function so it doesn't hurt the time
    sortedInput = list(L)
    swap = True
    #Not as efficient as a quicksort, but it gets the job done using loops (both a while and a for)
    while(swap == True):
        swap = False #If swap is never changed then I know that the list is properly sorted
        for i in range(len(sortedInput)-1):
            if sortedInput[i] > sortedInput[i+1]:
                swap = True
                temp = sortedInput[i]
                sortedInput[i] = sortedInput[i+1]
                sortedInput[i+1] = temp
    return sortedInput#return a value

# Numpy's sort function
def numpySort():
    newL = list(L)
    return np.sort(newL)

# Sorting with pythons built in function
def sortWithoutLoops():
    newL2 = list(L)
    newL2.sort()
    return newL2

# Searching with a loop
def searchWithLoops():
    for i in range(len(L)):
        if random.L == L[i]:
            return True
    return False

# Searching without a loop
def searchWithoutLoops():
    return random.L in L

# Numpy's search, which is pretty inefficient when you just want a T/F response, but much more effective if you're looking for more.
def numpySearch():
    return np.any(np.in1d(L, random.L))

if __name__ == "__main__":
    import timeit as ti
    print "Sort without loops: " + str(ti.timeit("sortWithoutLoops()", setup="from __main__ import sortWithoutLoops", number=10))
    print "Sort with numpy: " + str(ti.timeit("numpySort()", "from __main__ import numpySort", number=10))
    print "Search with loops: " + str(ti.timeit("searchWithLoops()", setup="from __main__ import searchWithLoops", number=10))
    print "Search without loops: " + str(ti.timeit("searchWithoutLoops()", setup="from __main__ import searchWithoutLoops", number=10))
    print "Search with numpy: " + str(ti.timeit("numpySearch()", setup="from __main__ import numpySearch", number=10))