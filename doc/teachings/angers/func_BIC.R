BIC <- function(reskmeans) {

  n<-length(reskmeans$cluster)
  k<-dim(reskmeans$centers)[1]
  p<-dim(reskmeans$centers)[2]
  traceS<-reskmeans$tot.withinss / n
  
  logLc=-0.5*(n*p + n*p*log(traceS/p))-n*log(k)+(n*p/2) *log(2*pi)
  
  nu<- k*p+1
  
  bic<- -2 *logLc + 2*nu*log(n) 
  return(bic)
}
