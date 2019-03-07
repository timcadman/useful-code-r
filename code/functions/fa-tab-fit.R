################################################################################
## Project: useful-code-r
## Script purpose: Function to put key fit statistics in a table
## Date: 5th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Takes FA object from Psych package as an argument

FaTableFit <- function(object){

fittab <- data.frame(matrix(NA, nrow=6, ncol=2)) 
fittab[, 1] <- c("Chi-squared", "Degrees of freedom", "P-value", "RMSEA", "RMS", "TLI")
fittab[, 2] <- c(object$chi, object$dof, object$PVAL, object$RMSEA[1], object$rms, object$TLI)
colnames(fittab) <- c("", "")

return(fittab)
}
