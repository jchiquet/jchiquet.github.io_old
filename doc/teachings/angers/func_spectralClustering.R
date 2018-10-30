SpectralClustering <- function (A,Q) {
  
  p <- ncol(A)
  if (Q > 1) {
    
    ## Normalized Laplacian
    D <- colSums(A)
    L <- diag(rep(1,p)) - 
      diag(D^(-1/2)) %*% A %*% diag(D^(-1/2))
    
    ## go into eigenspace
    U <- eigen(L)$vectors
    U <- U[,c((ncol(U)-Q+1):ncol(U))]
    U <- U / rowSums(U^2)^(1/2)
    
    ## Applying the K-means in the eigenspace
    cl <- kmeans(U, Q, nstart = 10, iter.max = 30)$cluster
  } else {
    cl <- as.factor(rep(1,ncol(A)))
  }
  
  return(cl)
}
