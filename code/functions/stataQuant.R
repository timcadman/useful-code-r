################################################################################
## Project: useful-code-r
## Script purpose: Divide people into quantiles using the same method as Stata
## Date: 7th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# This feels really clunky but it seems to work. Essentially the issue seems to be
# that the "cut" function in R works differently to the "cutpoints" function in Stata,
# namely that cut in R doesn't include upper and lower values on either side of breaks. 
# You get round this in R  by appending an upper and lower break point (essentially 
# infinity as these values are not possible) and you get the same as Stata. I'm sure
# there is a better way to do it than this!!
#
# Arguments
#
# var: variable from which to create quantiles
# quantile: number of quantiles, e.g. 4 = quartiles, 10 = deciles.

stataQuant <- function(var, quantile){

  q1 <- 1/quantile
  q2 <- 1 - 1/quantile
  
  perc.r <- as.numeric(quantile(var, seq(q1, q2, by=q1), na.rm=TRUE)) 
  
  first.changes <- function(d) { ##useful function I found online to get break points
    p <- cumsum(rle(d)$lengths) + 1
    p[-length(p)]
  }
  
  labels <- first.changes(perc.r) 
  labels <- append(labels, 1, 0)
  labels <- append(labels, quantile, length(labels)) 
  
  perc.stata <- append(perc.r, 99999)
  perc.stata <- append(perc.stata, -99999, after=0)
  
  perc.cut.fac <- cut(var, breaks = unique(perc.stata), labels=labels)
  
  perc.cut.fac <- as.numeric(levels(perc.cut.fac))[perc.cut.fac]
  
  return(perc.cut.fac)
  
}