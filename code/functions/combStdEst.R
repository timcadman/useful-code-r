require(dplyr)
require(magrittr)
require(semTools)

combStdEst <- function(object, digits = 2){

varnum <- length(object[[1]]@Fit@est)

imputations <- length(object)

std.tab <- data.frame(matrix(NA, nrow = varnum , ncol = imputations))
se.tab <- std.tab

## Extract values from each imputation model 
for(i in 1:imputations){
std.tab[, i] <- standardizedSolution(object[[i]]) %>%
dplyr::select(est.std)
}

for(i in 1:imputations){
se.tab[, i] <- standardizedSolution(object[[i]]) %>%
dplyr::select(se)
}

## Create dataframe to hold pooled results 
pooled.tab <- data.frame(matrix(NA, nrow = varnum, ncol = 9))
colnames(pooled.tab) <- c("lhs", "rhs", "op", "std.all", "se", "ci.lower", 
	                      "ci.upper", "statistic", "pvalue")

## Get parameter names
par_names <- standardizedSolution(object[[1]]) %>%
dplyr::select(lhs, rhs, op)

## Get model df
model_df <- fitMeasures(object[[1]], "df")

## Create dataframe with pooled estimates
pooled.tab %<>%
mutate(lhs = par_names$lhs,
	rhs = par_names$rhs,
	op = par_names$op,
       std.all = as.numeric(mi.meld(std.tab, se.tab, byrow = FALSE)[[1]]),
       se = as.numeric(mi.meld(std.tab, se.tab, byrow = FALSE)[[2]]),
       ci.lower = std.all - se * 1.96,
       ci.upper = std.all + se * 1.96,
       statistic = std.all / se,
       pvalue = 2 * pt(abs(statistic), model_df, lower.tail = FALSE))
	   
pooled.tab[, 4:9] <- round(pooled.tab[, 4:9], digits)

return(pooled.tab)
}