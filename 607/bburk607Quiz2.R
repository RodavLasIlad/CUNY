##### Question 1 #####
vec <- c(1:7, 6:14, 17:20)

##### Question 2 #####
vec.char <- as.character(vec)

##### Question 3 #####
vec.fact <- as.factor(vec)

##### Question 4 #####
length(unique(vec.fact))

##### Question 5 #####
vec.math <- 3 * (vec)^2 -4*(vec) + 1

##### Question 6 #####
leastSqReg <- function(X, y){
  return (solve(t(X) %*% X) %*% t(X) %*% y)
}
X <- matrix(c(1,5,8,1,4,9,1,6,4,1,2,7,1,3,4,1,2,9,1,7,6,1,8,4), ncol=3, byrow=T)
y <- c(45.2, 46.9, 31.0, 35.3, 25.0, 43.1, 41, 35.1)
leastSqReg(X, y)

##### Question 7 #####
list.named <- list(first=1, second=2, third=3)

##### Question 8 #####
df.char <- c(letters[1:10])
df.fact <- as.factor(rep(c("low", "mid", "high"), length.out=10))
df.numb <- c(1:10)
df.date <- as.Date(c(Sys.Date() - 0:9))
df <- data.frame(df.char, df.fact, df.numb, df.date)

##### Question 9 #####
df.fact <- as.factor(rep(c("low", "mid", "high"), length.out=10))
levels(df.fact) <- c(levels(df.fact), "highest")
df.fact[length(df.fact) + 1] <- "highest"

##### Question 10 #####
temps <- read.csv("temperatures.csv")

##### Question 11 #####
msmts <- read.table("C:\\Other\\measurements.txt", sep = "\t")

##### Question 12 #####
library(RCurl)
page <- getURL("http://wordpress.org/plugins/about/readme.txt")
page <- read.table(tc <- textConnection(page), sep="|")
close(tc)

##### Question 13 #####
factorial <- 1
for (i in 12:1){
  factorial <- factorial * i
}

##### 14 #####
balance <- 1500
for (i in (1:(6*12))){
  balance <- balance * 1.0324
}
balance <- round(balance, digits=2)

##### 15 #####
vec.third <- c(10:30)
sum(vec.third[seq(0, length(vec.third), 3)])

##### 16 #####
x <- 2
x.sum <- 0
for(i in 1:10){
  x.sum <- x.sum + (x^i)
  print(x.sum)
}

##### 17 #####
x.sum <- 0
i <- 1
while(i < 11){
  x.sum <- x.sum + (x^i)
  i <- i+1
}

##### 18 #####
sum(x^(1:10))

##### 19 #####
vector.by.fives <- seq(20, 50, 5)

##### 20 #####
example.ten <- c(rep("example", 10))

##### 21 #####
quadratic <- function(a,b,c){
  pos <- (-b + sqrt(b^2 - 4 * a * c))/(2*a)
  neg <- (-b - sqrt(b^2 - 4 * a * c))/(2*a)
  return(c(pos, neg))
}
quadratic(1,-3, -4)