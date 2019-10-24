################################################################################
## Project: useful-code-r
## Script purpose: Get odds ratio and CIs from glm object
## Date: 14th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Version of lrTab for use with multiply imputed data
#
# Argument:
#
# object: glm object
# pstats: either "pvalues" for separate column, "pstars" for stars appended to
# odds ratio, or "none" for none.
#
# output: dataframe with OR (lower CI - upper CI)

lrTabImp <- function(object, pstats){

## ---- Pool imputed data ------------------------------------------------------
object_p <- pool(object)

## ---- Extract the stats -----------------------------------------------------
npred <- (length(object_p$pooled$estimate) - 1)

stats <- round(summary(object_p, conf.int = TRUE, conf.level = 0.90,
 exponentiate = TRUE), 2)

or <- stats$estimate[2 : (npred + 1)]
ci_low <- stats$"5 %"[2 : (npred + 1)]
ci_high <- stats$"95 %"[2 : (npred + 1)]

## ---- This section is to get the p values ------------------------------------
p_values <- stats$p.value[2 : (npred + 1)]
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
## ---- Output -----------------------------------------------------------------
if(pstats == "pvalues"){

out <- data.frame(matrix(NA, 
	nrow = npred, 
	ncol = 3))

colnames(out) <- c("variable", "odds ratio (95 % CI)", "pvalue")
out[, 1] <- attributes(object_p$pooled)$row.names[2: (npred + 1)]
out[, 2] <- paste(or, 
	          paste(
	            paste0("(", ci_low),
	            "-",
	            paste0(ci_high, ")")),
	          sep = " ")
out[, 3] <- p_values

}

else if(pstats == "stars"){

out <- data.frame(matrix(NA, 
	nrow = npred, 
	ncol = 2))

colnames(out) <- c("variable", "odds ratio (95 % CI)")
out[, 1] <- attributes(object_p$pooled)$row.names[2: (npred + 1)]
out[, 2] <- paste(or, 
	          paste(
	            paste0("(", ci_low),
	            "-",
	            paste0(ci_high, ")", p_list)),
	          sep = " ")

}

else if(pstats == "none"){

out <- data.frame(matrix(NA, 
	nrow = npred, 
	ncol = 2))

colnames(out) <- c("variable", "odds ratio (95 % CI)")
out[, 1] <- attributes(object_p$pooled)$row.names[2: (npred + 1)]
out[, 2] <- paste(or, 
	          paste(
	            paste0("(", ci_low),
	            "-",
	            paste0(ci_high, ")")),
	          sep = " ")

}

return(out)

}