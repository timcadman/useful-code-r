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
  select(rhs, std.all, se, pvalue) 

colnames(tab_struc) <- c("", "Beta", "Std.Err", "P-value")

return(tab_struc)

}