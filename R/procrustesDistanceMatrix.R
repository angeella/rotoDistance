#' @title Compute procrustes-based distance matrix
#' @description It compute the distance matrix based on distance from
#' \code{procrustesDistance}
#' @usage procrustesDistanceMatrix(X)
#' @param X array of orthogonal or data aligned matrices where the first dimension is the
#' number of matrices to be analyzed
#' @return procrustes-based distance matrix
#' @export
#' @author Angela Andreella


procrustesDistanceMatrix <- function(X){

  N <- dim(X)[1]
  ncomb <- t(combn(N, 2))
  D <- matrix(0, nrow = N, ncol = N)

  D[upper.tri(D)] <- sapply(seq(nrow(ncomb)),
                         function(x) procrustesDistance(X[ncomb[x,1],,],
                                                        X[ncomb[x,2],,]))

  D <- D + diag(N)
  D[lower.tri(D)] <- D[upper.tri(D)]

  return(D)
}