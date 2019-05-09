################################################################################
## Project: useful-code-r
## Script purpose: Function to create Lavaan model syntax
## Date: 2nd April 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Give it factor name and a string of variables, it will give you lavaan
# syntax for latent variable model

createMod <- function(name, varlist){

mod <- paste(varlist, collapse = " + ")
mod <- paste(name, mod, sep = " =~ ")
mod <- paste(mod, "\n", sep = " ")

return(mod)
}