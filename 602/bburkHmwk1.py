#1. fill in this function
#   it takes a list for input and return a sorted version
#   do this with a loop, don't use the built in list functions
def sortwithloops(input):
    sortedInput = input
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
	
#2. fill in this function
#   it takes a list for input and return a sorted version
#   do this with the built in list functions, don't us a loop
def sortwithoutloops(input):
    sInput2 = input
    sInput2.sort()
    return sInput2 #return a value

#3. fill in this function
#   it takes a list for input and a value to search for
#	it returns true if the value is in the list, otherwise false
#   do this with a loop, don't use the built in list functions
def searchwithloops(input, value):
    for i in range(len(input)):
        if value == input[i]:
            return True #Breaks
    return False #return a value

#4. fill in this function
#   it takes a list for input and a value to search for
#	it returns true if the value is in the list, otherwise false
#   do this with the built in list functions, don't use a loop
def searchwithoutloops(input, value):
    return value in input #return a value	

if __name__ == "__main__":	
    L = [5,3,6,3,13,5,6]	

    print sortwithloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print sortwithoutloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print searchwithloops(L, 5) #true
    print searchwithloops(L, 11) #false
    print searchwithoutloops(L, 5) #true
    print searchwithoutloops(L, 11) #false