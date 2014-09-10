##### Question 1 #####
Count.NAs <- function(v){
  return (sum(is.na(v)))
}
test.v <- c(1:10, NA, NA, 11, NA)
Count.NAs(test.v)

##### Question 2 #####
Count.NAs.df <- function(df){
  na.vec <- vector()
  for (i in 1:ncol(df)){
    na.vec[i] <- Count.NAs(df[,i])
    #names(na.vec) <- c(names(na.vec)[1:i], names(df)[i])
  }
  names(na.vec) <- names(df)
  return (na.vec)
}

test.df <- mtcars
test.df[1,1] <- NA
Count.NAs.df(test.df)

##### Question 3 #####
Get.Stats <- function(v){
  #### Min and max ####
  v.min <- v[1]
  v.max <- v[1]
  for (i in c(1:length(v))){
    if (v[i] > v.max){
      v.max <- v[i]
    } else if (v[i] < v.min){
      v.min <- v[i]
    }
  }
  print("Min/Max")
  print(v.min)
  print(v.max)
  #### Mean ####
  v.mean <- sum(v)/length(v)
  print("Mean")
  print(v.mean)
  
  #### Median #### with my own sort (since we're not supposed to use built-ins)
  swap <- T
  while(swap == T){
    swap <- F
    for (i in 1:(length(v)-1)){
      if (v[i] > v[i+1]){
        swap <- T
        temp <- v[i]
        v[i] <- v[i+1]
        v[i+1] <- temp
      }
    }
  }
  v.median <- Get.Median(v)
  print("Median")
  print(v.median)
  
  #### Quartiles #####
  half <- length(v)/2
  if(length(v) %% 2==0){
    v.firstquart <- Get.Median(v[c(1:half)])
    v.thirdquart <- Get.Median(v[c((half + 1):length(v))])
  } else {
    v.firstquart <- Get.Median(v[c(1:(half - 0.5))])
    v.thirdquart <- Get.Median(v[c((half + 0.5):length(v))])
  }
  print("Quarts")
  print(v.firstquart)
  print(v.thirdquart)
  
  #### Standard Deviation ####
  v.var <- sum((v.mean-v)^2)
  v.sd <- sqrt(v.var)
  print("SD")
  print(v.sd)
  
  #### Count NAs ####
  v.nas <- Count.NAs(v)
  print("NAs")
  print(v.nas)
  
  #### Output ####
  sum.stats <- c(v.min, v.max, v.mean, v.firstquart, v.median, v.thirdquart, v.sd, v.nas)
  names(sum.stats) <- c("Min", "Max", "Mean", "1st.Quartile", "2nd.Quartile.aka.Median", "3rd.Quartile", "Standard.Deviation", "NAs")
  return(sum.stats)
}
Get.Median <- function(v){
  if(length(v) %% 2 == 0){ #Even entries
    v.mid.index <- length(v)/2
    v.median <- (v[v.mid.index + 1] + v[v.mid.index])/2
  }
  else { #Odd entries
    v.mid.index <- (length(v)/2) + 0.5
    v.median <- v[v.mid.index]
  }
  return (v.median)
}
a <- c(5,8,4,4,6,3,8)
Get.Stats(a)

##### Question 4 #####
Vec.Info <- function(v){
  v.distinct <- length(unique(v))
  v.most.common.count <- max(table(v))
  v.most.common <- c(names(subset(table(v), table(v) == v.most.common.count)))
  v.missing.count <- Count.NAs(v)
  info <- c(v.distinct, v.most.common, v.most.common.count, v.missing.count)
  names(info) <- c("Distinct.Elements", "Most.Common", "Most.Common.Count", "NAs")
  return(info)
}
test <- c("Hi", "Bye", "See ya", "Later", "Hi", "Sup", "Howzit", NA)
test2 <- Vec.Info(test)