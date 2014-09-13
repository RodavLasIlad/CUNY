##### Loading in Test Data #####
setwd("C:\\Users\\Brett\\Dropbox\\CUNY\\607")
dataset <- read.csv("entropy-test-file.csv")

##### Question 1 #####
# Create a function entropy() that takes a vector d as input and returns a single numeric value that is the entropy of the vector:
entropy <- function(d){
  prob <- table(d)/sum(table(d))
  e <- sum((-prob) * log(prob, base=2))
  return (e)
}
# Test
entropy(dataset$answer)

##### Question 2 #####
infogain <- function(d, a){
  ed <- entropy(d)
  t <- table(ave(d, as.factor(a), FUN=entropy))
  t <- t/sum(t)
  s <- sum(t*as.numeric(names(t)))
  return(ed - s)
}
# Tests
infogain(dataset$answer, dataset$attr1)
infogain(dataset$answer, dataset$attr2)
infogain(dataset$answer, dataset$attr3)

##### Question 3 #####
library(plyr)
decide <- function(df, col){
  ig <- sapply((1:ncol(df))[-col], function(x) infogain(df[,col], df[,x]))
  names(ig) <- names(df[-col])
  return(ig)
}

decide(dataset, 4)