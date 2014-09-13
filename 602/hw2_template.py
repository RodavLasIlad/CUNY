#1. fill in this class
#   it will need to provide for what happens below in the
#	main, so you will at least need a constructor that takes the values as (Brand, Price, Safety Rating),
# 	a function called showEvaluation, and an attribute carCount
class CarEvaluation:
    # Initializes the count at 0
    carCount = 0
    def __init__(self, brand, price, safetyRating):
        # Increases the count
        CarEvaluation.carCount += 1
        self.brand = brand
        self.price = price
        self.safetyRating = safetyRating
    def showEvaluation(self):
        # Returns the desired string        
        print "The %s has a %s price and its safety is rated a %d" % (self.brand, self.price, self.safetyRating)
        
        
         
#2. fill in this function
#   it takes a list of CarEvaluation objects for input and either "asc" or "des"
#   if it gets "asc" return a list of car names order by ascending price
# 	otherwise by descending price
def sortbyprice(carL, order):
    #I just have them fill out lists, so it's a little more scalable in the future, then it adds each car to either a low/med/high list
    low = []
    med = []
    high = []
    for car in carL:
        if car.price == 'High':
            high.append(car.brand)
        elif car.price == 'Med':
            med.append(car.brand)
        else:
            low.append(car.brand)
    # Sorts appropriately whether ascending or descending
    if order == "asc":
        return (low + med + high)
    else:
        return (high + med + low)

#3. fill in this function
#   it takes a list for input of CarEvaluation objects and a value to search for
#	it returns true if the value is in the safety  attribute of an entry on the list,
#   otherwise false
def searchforsafety(carL, desiredSafety):
    # Creates a list of all safety ratings
    presentSafety = []
    for car in carL:
        presentSafety.append(car.safetyRating)
    # Checks for the desired safety level
    return (desiredSafety in presentSafety)
        
    
	
# This is the main of the program.  Expected outputs are in comments after the function calls.
if __name__ == "__main__":	
    eval1 = CarEvaluation("Ford", "High", 2)
    eval2 = CarEvaluation("GMC", "Med", 4)
    eval3 = CarEvaluation("Toyota", "Low", 3)


    print "Car Count = %d" % CarEvaluation.carCount # Car Count = 3

    eval1.showEvaluation() #The Ford has a High price and it's safety is rated a 2
    eval2.showEvaluation() #The GMC has a Med price and it's safety is rated a 4
    eval3.showEvaluation() #The Toyota has a Low price and it's safety is rated a 3
    L = [eval1, eval2, eval3]

    print sortbyprice(L, "asc"); #[Toyota, GMC, Ford]
    print sortbyprice(L, "des"); #[Ford, GMC, Toyota]
    print searchforsafety(L, 2); #true
    print searchforsafety(L, 1); #false