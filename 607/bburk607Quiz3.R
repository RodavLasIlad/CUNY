##### Question 1 #####
mean.obs <- function(x){
  total <- 0
  count <- 0
  for (obs in x){
    count <- count + 1
    total <- total + obs
  }
  return (total/count)
}
v <- c(1:10)
mean.obs(v)

##### Question 2 #####
# Choosing to remove NAs and not factor them into the count
mean.obs <- function(x){
  x <- x[complete.cases(x)]
  total <- 0
  count <- 0
  for (obs in x){
    count <- count + 1
    total <- total + obs
  }
  return (total/count)
}
v <- c(1:10, NA)
mean.obs(v)

##### Question 3 #####
gcd <- function(x,y){
  maxi <- max(c(x,y))
  mini <- min(c(x,y))
  remainder <- 1
  while(remainder != 0){
    remainder <- maxi %% mini
    maxi <- mini
    mini <- remainder
  }
  return (maxi)
}
gcd(108, 30)

##### Question 4 #####
euclids.gcd <- function(x,y){
  while(x != y){
    if (x > y){
      x <- x - y
    }else{
      y <- y - x
    }
  }
  return (x)
}
euclids.gcd(108, 30)

##### Question 5 #####
algebra <- function(x,y){
  return (x^(2)*y+2*x*y-x*y^(2))
}
algebra(1,2)

##### Question 6 #####
#Assuming they're in the wd
price.data <- read.csv("week-3-price-data.csv", header=T)
make.model <- read.csv("week-3-make-model-data.csv", header=T)
merged <- merge(make.model, price.data, by="ModelNumber")
nrow(merged)
#28 entries in price.data, 27 entries in the merged data set, after applying merged[order(merged$ID),] we can see that #12 is missing, and in reviewing, it seems there is a typographical error in the model number
price.data[which(price.data$ModelNumber == 23120),]$ModelNumber <- 2312
merged <- merge(make.model, price.data, by="ModelNumber")
nrow(merged)
#Fixed!

##### Question 7 #####
price.data <- read.csv("week-3-price-data.csv", header=T)
make.model <- read.csv("week-3-make-model-data.csv", header=T)
merged <- merge(make.model, price.data, by="ModelNumber", all.y=T)
merged

##### Question 8 #####
merged.ss <- subset(merged, Year == 2010)
merged.ss

##### Question 9 #####
merged.ss2 <- subset(merged, Color == "Red" & Price > 10000)
merged.ss2

##### Question 10 #####
merged.ss2.clean <- merged.ss2[,-c(1, 6)]
merged.ss2.clean

##### Question 11 #####
not.nchar <- function(char.vector){
  return(sapply(strsplit(char.vector, ""), length))
}
not.nchar(c("hello", "goodbye", "hello again"))

##### Question 12 #####
concat <- function(x,y){
  if(length(x) == length(y)){
    return (sapply(1:length(x), function(a) z[a] <- sprintf("%s %s",x[a], y[a])))
  } 
  else if (length(x) > length(y)){
    stop("Error, length of x > y")
    diff <- length(x) - length(y)
    temp <- (sapply(1:length(y), function(a) z[a] <- sprintf("%s %s",x[a], y[a])))
    return (append(temp, x[(length(y) + 1):(length(y) + diff)]))
  }
  else {
    stop("Error, length of y > x")
    diff <- length(y) - length(x)
    temp <- (sapply(1:length(x), function(a) z[a] <- sprintf("%s %s",x[a], y[a])))
    return (append(temp, y[(length(x) + 1):(length(x) + diff)]))
  }
}
h <- c("hello", "bye")
i <- c("again", "again")
concat(h,i)

##### Question 13 #####
three.chars <- function(x){
  split <- strsplit(x, "")[[1]]
  vowels <- c("a", "e", "i", "o", "u") #Assuming y is not a vowel
  vowel.present <- F
  vowel.index <- 1
  for (i in split){
    if (i %in% vowels & vowel.present == F){
      vowel.present <- T
      vowel.index <- which(split==i)
    }
  }
  if (vowel.present){
    if (length(split) >= vowel.index+2){
      return (split[vowel.index:(vowel.index+2)])
    } 
    else {
      diff <- (vowel.index + 2) - length(split)
      stop("Not enough valid characters to return 3")
      return (split[vowel.index:(vowel.index+2-diff)])
    }
  }
  else {
    stop("No vowels found")
  }
}
three.chars("hello")
three.chars("hel")
three.chars("hll")

##### Question 14 #####
day <- c(1,2,3)
month <- c(4,5,6)
year <- c(1999, 2000, 2014)
date.df <- data.frame(day, month, year)
date.df <- cbind(date.df, as.Date(paste(year, month, day, sep="/")))
names(date.df)[4] <- "asDate"
date.df

##### Question 15 #####
test <- "01-19-1984"
fixed <- as.Date(test, "%m-%d-%Y")
fixed

##### Question 16 #####
month <- format.Date(fixed, "%m")
month

##### Question 17 #####
dates <- seq(as.Date("2005/1/1"), as.Date("2014/12/31"), by = "day")
dates