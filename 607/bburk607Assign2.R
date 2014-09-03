# 1.a
queue <- c("James", "Mary", "Steve", "Alex", "Patricia")

# 1.b
queue <- c(queue, "Harold")

# 1.c
queue <- queue[2:length(queue)]

# 1.d (Making it nearly as complicated as possible)
queue[c(1:(which(queue == "Steve")-1), which(queue == "Patricia"), (which(queue == "Steve"):length(queue))[-((length(queue) - which(queue == "Steve")))])]

# 1.e
queue <- subset(queue, queue != "Harold")

# 1.f
queue <- subset(queue, queue != "Alex")

# 1.g
which(queue == "Patricia")

# 1.h
length(queue)

# 2
quadratic <- function(a,b,c){
  if (a == 0){
    return("No Solution")
  }
  pos <- (-b + sqrt((b^2 - 4 * a * c) +0i))/(2*a)
  neg <- (-b - sqrt((b^2 - 4 * a * c) + 0i))/(2*a)
  # alternatively (if you don't want imaginary answers):
  # if (b^2 < (4 * a * c)) { 
  #return("No Solution")
  #}
  if (pos == neg){
    return(pos)
  }
  return(c(pos, neg))
}

# 3
one.to.onek <- c(1:1000)
length(one.to.onek[intersect(intersect(which(one.to.onek %% 3 != 0), which(one.to.onek %% 7 != 0)), which(one.to.onek %% 11 != 0))])

# 4
pythag.trip <- function(a, b, c){
  big <- max(c(a,b,c))^2
  if(sum((c(a,b,c))[-which.max(c(a,b,c))]^2) == big){
    return(T)
  } else {
    return(F)
  }
}