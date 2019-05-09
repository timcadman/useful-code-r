################################################################################
## Project: useful-code-r
## Script purpose: Creates table header including model N
## Date: 1st April 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

titleN <- function(title, object){

n <- unlist(object@SampleStats@nobs)
title_out <- paste0(title, " (n=", n, ")")

return(title_out)
}
