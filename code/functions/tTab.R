################################################################################
## Project: useful-code-r
## Script purpose: output t-test results for descriptives table
## Date: 14th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Analogue of nPerc: used to get info for table 1, when stratified by different
# levels of an independent variable.
#
# Arguments:
#
# data = data
# var_ind = indepdent variable
# var_dep = dependent variable
#
# Output:
#
# List with two elements: (i) mean (sd) level 1, (ii) mean (sd)sig level 2

tTab <- function(data, var_ind, var_dep){

v_ind <- data[, var_ind]
v_dep <- data[, var_dep]

out <- list()

stat <- CreateTableOne(vars = var_dep, strata = var_ind, data = data)

n.1 <- round(stat[[1]][[1]][4], 2)
n.2 <- round(stat[[1]][[2]][4], 2)

s.1 <- round(stat[[1]][[1]][5], 2)
s.2 <- round(stat[[1]][[2]][5], 2)

if(attributes(stat$ContTable)$pValues[1] < 0.001){
	p = "***"
}
else if (attributes(stat$ContTable)$pValues[1] < 0.01 & 
	attributes(stat$ContTable)$pValues[1] >= 0.001){
	p = "**"
}
else if (attributes(stat$ContTable)$pValues[1] < 0.005 & 
	attributes(stat$ContTable)$pValues[1] >= 0.01){
	p = "*"
}
else{
	p = ""
}

s.1.b <- paste0("(",  s.1, ")")
s.2.b <- paste0("(",  s.2, ")", p)

out[1] <- paste(n.1, s.1.b, sep = " ")
out[2] <- paste(n.2, s.2.b, sep = " ")

return(out)
}