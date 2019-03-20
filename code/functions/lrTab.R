################################################################################
## Project: useful-code-r
## Script purpose: Get odds ratio and CIs from glm object
## Date: 14th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

#
# Argument:
#
# object: glm object
#
# output: dataframe with OR (lower CI - upper CI)

lrTab <- function(object){

## ---- Extract the values -----------------------------------------------------
npred <- length(attributes(object$terms)$term.labels) 

out <- data.frame(matrix(NA, 
	nrow = npred, 
	ncol = 2))

colnames(out) <- c("variable", "odds ratio (95 % CI)")
out[, 1] <- attributes(object$terms)$term.labels

or <- round(exp(coefficients(object)), 2)[2 : (npred + 1)]
ci <- round(exp(confint(object, level = 0.90)), 2)[2 : (npred + 1), ]

ci_low <- ci[, 1]
ci_high <- ci[, 2]

## ---- This section is to get the p values ------------------------------------
p_values <- coef(summary(object))[,4][2 : (npred + 1)]
p_list <- vector(length = npred)

for(i in 1 : npred){

if(p_values[i] < 0.001){
	p_list[i] = "***"
}
else if (p_values[i] < 0.01 & i >= 0.001){
	p_list[i] = "**"
}
else if (p_values[i] < 0.05 & i >= 0.01){
	p_list[i] = "*"
}
else{
	p_list[i] = ""
}
}

## ---- Paste it all togethers ------------------------------------------------
out[, 2] <- paste(or, 
	          paste(
	            paste0("(", ci_low),
	            "-",
	            paste0(ci_high, ")", p_list)),
	          sep = " ")

return(out)

}