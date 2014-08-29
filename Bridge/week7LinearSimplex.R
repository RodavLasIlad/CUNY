simplex <- function(mat1){
 while(sum(mat1[nrow(mat1),]<0)>0){
    pivotCol <- which.min(mat1[nrow(mat1),]) #this returns the index value of the smallest number in the last row
    pivotRow <- which.min(sapply(1:(nrow(mat1)-1), function(i) mat1[i, ncol(mat1)]/(mat1[i, pivotCol]))) #chooses the row where the last row divided by the pivotcol has the lowest value
    mat1[pivotRow,] <- (1/mat1[pivotRow, pivotCol]) * mat1[pivotRow,]
    mat1 <- rbind(mat1[pivotRow,], t(sapply((1:nrow(mat1))[-pivotRow], function(i) mat1[i,] <- mat1[i,] - (mat1[i,pivotCol]*mat1[pivotRow,]))))
  }
  return(mat1[nrow(mat1),])
}