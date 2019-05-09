################################################################################
## Project: useful-code-r
## Script purpose: Report the structural components of SEM model
## Date: 7th February 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Function takes lavaan object as an argument

lavTableStruc <- function(object){

tab_struc <- parameterEstimates(object, standardized=TRUE) %>% 
  filter(op == "~") %>%
  select(lhs, rhs, est, std.all, ci.lower, ci.upper, pvalue) 

colnames(tab_struc) <- c("Outcome", "", "Coeffiecient", "Beta", "Lower CI", "Upper CI", 
	                     "P-value")

#tab_struc[, 4] <- formatC(tab_struc[, 4], digits = 3, format = "f")

return(tab_struc)

}

