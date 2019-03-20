################################################################################
## Project: useful-code-r
## Script purpose: Paste together n and percentage for descriptives table
## Date: 14th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# This does a cross-tab of an outcome by an independent variables. It returns
# the number and percentage in the highest category (1), where the percentage
# is the percentage in that level of the independent variable. Also appends
# stars on the second value indicating sig difference. This is designed
# primarily for the parent-personality table 1, but may be useful elsewhere.

# Arguments:
#
# data = data
# var_ind = indepdent variable
# var_dep = dependent variable
#
# Output:
#
# List with two elements: (i) n (%) level 1, (ii) n (%)sig level 2

nPerc <- function(data, var_ind, var_dep){

v_dep <- data[, var_dep]
v_ind <- data[, var_ind]

out <- list()

stat <- CrossTable(v_dep, v_ind, chisq = TRUE)

n.1 <- stat[[1]][2]
n.2 <- stat[[1]][4]

p.1 <- round(stat[[3]][2], 2)
p.2 <- round(stat[[3]][4], 2)

if(stat[[5]][[3]] < 0.001){
	p = "***"
}
else if (stat[[5]][[3]] < 0.01 & stat[[5]][[3]] >= 0.001){
	p = "**"
}
else if (stat[[5]][[3]] < 0.005 & stat[[5]][[3]] >= 0.01){
	p = "*"
}
else{
	p = ""
}

p.1.b <- paste0("(",  p.1, ")")
p.2.b <- paste0("(",  p.2, ")", p)

out[1] <- paste(n.1, p.1.b, sep = " ")
out[2] <- paste(n.2, p.2.b, sep = " ")

return(out)
}