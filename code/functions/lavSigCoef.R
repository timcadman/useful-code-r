################################################################################
## Project: useful-code-r
## Script purpose: Extracts lavaan structural info and adds significance stars 
## Date: 29th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################
library(lavaan)
library(dplyr)
source("c:/repos/useful-code-r/code/functions/sigStars.r")

lavSigCoef <- function(object){

coefs <- parameterEstimates(object, standardized = TRUE) %>%
filter(op == "~")

coefs$std.all <- round(coefs$std.all, 2)
coefs$sig <- sapply(coefs$pvalue, FUN = sig_stars)

plot_sig <- paste0(format(coefs$std.all, drop0Trailing = FALSE), 
	                    coefs$sig)

return(plot_sig)

}