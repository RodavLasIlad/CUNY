# Part 1: Demonstrating assignment:
a <- 5
a = 5
assign("a", 5)

# Part 2: sum() and is.na()
vectorEx <- c(1, 4, 5, 3, NA, 5, 3, NA)
sum(is.na(vectorEx))

# Part 3: difference between require and library
if(TRUE){
  library(fakeLib)
  print(5)
} # This will fail before it does the print
if(TRUE){
  require(fakeLib)
  print(5)
} # This will print even if the library doesn't exist

# The latter is usually used in functions, as it will still attempt to go through the rest of the function, library is usually used when exploring, as it will automatically fail the function