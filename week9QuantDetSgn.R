sgn <- function(n){
  return((-1)^(n+1)) #sign function--returns 1 if even, -1 if odd
}
determinant <- function(A){
  if(dim(A)[1] != dim(A)[2]) stop("Not a square matrix")
  if(ncol(A)==1){ #if the matrix has 1 column, it returns the only entry
    return(A[1,1])
  }else{
    return(do.call(sum, lapply(1:ncol(A), function(i) sgn(i)*A[1,i] * determinant(A[-1,-i,drop=F])))) # finds the sgn of each number, multiplies it by the current value in row 1, then finds the determinant of the rest of the row, and finally it sums all the values
  }
}

noninvert <- matrix(c(1,2,3,4,5,6,7,8,9), byrow=T, ncol=3)
invert <- matrix(c(1,2,3,0,2,3,0,0,4), byrow=T, ncol=3)
determinant(noninvert)
determinant(invert)

M <- matrix(c(1:4), byrow = TRUE , nrow = 2)
