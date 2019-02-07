################################################################################
## Project: useful-code-r
## Script purpose: Function to replicate lavaan summary header in a table
## Date: 7th February 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Takes lavaan object as argument

lavTableSum <- function(object){
sumtab <- data.frame(matrix(NA, nrow=5, ncol=2)) 

labels <- c("Number of free parameters", "Optimisation method", "Total number of observations", 
	"Number of observations used", "Estimator")

sumtab[ , 1] <- labels
sumtab[1, 2] <- enjsch.fit.b@optim$npar
sumtab[2, 2] <- enjsch.fit.b@Options$optim.method
sumtab[3, 2] <- enjsch.fit.b@Data@norig
sumtab[4, 2] <- enjsch.fit.b@Data@nobs
sumtab[5, 2] <- enjsch.fit.b@Options$estimator
colnames(sumtab) <- c("", "")

return(sumtab)
}
