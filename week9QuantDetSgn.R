sgn <- function(n){
  return((-1)^(n)) #sign function--returns 1 if even, -1 if odd
}
determinant <- function(A){
  if(ncol(A)==1){
    return(A[1,1])
  }else{
    return(do.call(sum, lapply(1:ncol(A), function(i) sgn(i)*A[1,i] * determinant(A[-1,-i,drop=F]))))
  }
}