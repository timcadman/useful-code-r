################################################################################
## Project: useful-code-r
## Script purpose: Function to put key fit statistics in a table
## Date: 7th February 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Takes lavaan object as argument

lavTableFit <- function(object){

fittab <- data.frame(matrix(NA, nrow=7, ncol=2)) 
fittab[, 1] <- c("Chi-squared", "Degrees of freedom", "P-value", "RMSEA", "SRMR", "CFI", "TLI")
fittab[, 2] <- as.numeric(fitMeasures(object, c("chisq", "df", "pvalue", "rmsea", "srmr", "cfi", "tli")))
colnames(fittab) <- c("", "")

return(fittab)
}