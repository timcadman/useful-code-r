################################################################################
## Project: useful-code-r
## Script purpose: output t-test results for descriptives table
## Date: 14th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# This does a does either a cross-tab or t-test of an outcome by an independent 
# variable. It returns either: (i) n(%) or (ii) mean(sd) for each level of the
# independent variable. It can also either append stars on the second value 
# indicating sig difference, or provide an additional column with the p value. 
# This is designed primarily for the parent-personality table 1, but may be 
# useful elsewhere.
#
# Arguments:
#
# data = data
# var_ind = indepdent variable
# var_dep = dependent variable
# type = either "t-test" or "chisq"
# pcol = TRUE/FALSE. Add separate column with p-values rather than appending
#        stars
#
# Output:
#
# List with two or three elements depending on value of pcol.

library(gmodels)
library(tableone)

extractDesc <- function(data, var_ind, var_dep, type, pcol){

v_ind <- data[, var_ind]
v_dep <- data[, var_dep]

out <- list()

## ---- Get stats for t-test ---------------------------------------------------
if(type == "t-test"){

stat <- CreateTableOne(vars = var_dep, strata = var_ind, data = data)

n.1 <- round(stat[[1]][[1]][4], 2)
n.2 <- round(stat[[1]][[2]][4], 2)

s.1 <- round(stat[[1]][[1]][5], 2)
s.2 <- round(stat[[1]][[2]][5], 2)

pval <- round(attributes(stat$ContTable)$pValues[1], 2)

}

## ---- Get stats for chi squared ----------------------------------------------
else{

stat <- CrossTable(v_dep, v_ind, chisq = TRUE)

n.1 <- stat[[1]][2]
n.2 <- stat[[1]][4]

s.1 <- round(stat[[3]][2], 2)
s.2 <- round(stat[[3]][4], 2)

pval <- round(stat[[5]][[3]], 2)

}

## ---- Get significance stars -------------------------------------------------
if(pval < 0.001){
	p = "***"
}
else if (pval < 0.01 & 
	pval >= 0.001){
	p = "**"
}
else if (pval < 0.005 & 
	pval >= 0.01){
	p = "*"
}
else{
	p = ""
}

s.1.b <- paste0("(",  s.1, ")")

if(pcol == FALSE){
s.2.b <- paste0("(",  s.2, ")", p)
out[1] <- paste(n.1, s.1.b, sep = " ")
out[2] <- paste(n.2, s.2.b, sep = " ")
}

else{
s.2.b <- paste0("(",  s.2, ")")
out[1] <- paste(n.1, s.1.b, sep = " ")
out[2] <- paste(n.2, s.2.b, sep = " ")
out[3] <- pval
}

return(out)
}