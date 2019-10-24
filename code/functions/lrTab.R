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

require(mice)

lrTab <- function(object, imputed, pstats){

if(imputed == TRUE){

object_p <- pool(object)

## ---- Extract the stats -----------------------------------------------------
npred <- (length(object_p$pooled$estimate) - 1)

stats <- round(summary(object_p, conf.int = TRUE, conf.level = 0.90,
 exponentiate = TRUE), 2)

varnames <- attributes(object_p$pooled)$row.names[2: (npred + 1)]

or <- stats$estimate[2 : (npred + 1)]
ci_lower <- stats$"5 %"[2 : (npred + 1)]
ci_upper <- stats$"95 %"[2 : (npred + 1)]

## ---- This section is to get the p values ------------------------------------
p_values <- round(stats$p.value[2 : (npred + 1)], 2)
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

}

else if(imputed == FALSE){

## ---- Extract the values -----------------------------------------------------
npred <- length(attributes(object$terms)$term.labels) 

or <- coefficients(object)[2 : (npred + 1)]
se <- summary(object)$coefficients[, 2][2 : (npred + 1)]

varnames <- attributes(object$terms)$term.labels

## ---- Calculate CIs ----------------------------------------------------------
ci_lower <- or - (1.96 * se)
ci_upper <- or + (1.96 * se)

## ---- Convert to OR ----------------------------------------------------------
or <- round(exp(or), 2)
ci_lower <- round(exp(ci_lower), 2)
ci_upper <- round(exp(ci_upper), 2)

## ---- This section is to get the p values ------------------------------------
p_values <- round(coef(summary(object))[,4][2 : (npred + 1)], 2)
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

}

## ---- Output -----------------------------------------------------------------
if(pstats == "pvalues"){

out <- data.frame(matrix(NA, 
	nrow = npred, 
	ncol = 3))

colnames(out) <- c("variable", "odds ratio (95 % CI)", "pvalue")
out[, 1] <- varnames
out[, 2] <- paste(or, 
	          paste(
	            paste0("(", ci_lower),
	            "-",
	            paste0(ci_upper, ")")),
	          sep = " ")
out[, 3] <- p_values

}

else if(pstats == "stars"){

out <- data.frame(matrix(NA, 
	nrow = npred, 
	ncol = 2))

colnames(out) <- c("variable", "odds ratio (95 % CI)")
out[, 1] <- varnames
out[, 2] <- paste(or, 
	          paste(
	            paste0("(", ci_lower),
	            "-",
	            paste0(ci_upper, ")", p_list)),
	          sep = " ")

}

else if(pstats == "none"){

out <- data.frame(matrix(NA, 
	nrow = npred, 
	ncol = 2))

colnames(out) <- c("variable", "odds ratio (95 % CI)")
out[, 1] <- varnames
out[, 2] <- paste(or, 
	          paste(
	            paste0("(", ci_lower),
	            "-",
	            paste0(ci_upper, ")")),
	          sep = " ")

}

return(out)

}