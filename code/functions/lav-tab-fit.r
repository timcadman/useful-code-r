################################################################################
## Project: useful-code-r
## Script purpose: Function to put key fit statistics in a table
## Date: 7th February 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Takes lavaan object as argument

lavTableFit <- function(object, imputed = FALSE){

## ---- Make a data frame to hold statistics -----------------------------------
fitstats <- c("chisq", "df", "pvalue", "rmsea", "srmr", "cfi", "tli")
fit.tab <- data.frame(matrix(NA, nrow = 7, ncol = 2))
fit.tab[, 1] <- fitstats
colnames(fit.tab) <- c("", "")

## ---- Multiply imputed data --------------------------------------------------

## We need to first get the fit statistics on each dataset

if(imputed == TRUE){

imputations <- length(object)

fit_imp <- data.frame(matrix(NA, nrow = 7, ncol = imputations))

for(i in 1:imputations){

print(i)

fit_imp[, i] <- fitMeasures(object[[i]], fitstats)
}

## Now we build the table with the mean fit statistics
fit.tab[1:7, 2] <- rowMeans(fit_imp[, 2:imputations], na.rm = TRUE)

## ---- Non-imputed data -------------------------------------------------------

## Else we just use values from the single data frame
} else if(imputed == FALSE){

fit.tab[, 2] <- as.numeric(fitMeasures(object, fitstats, 2))
}

## ---- Now we just round the output -------------------------------------------
fit.tab[1:7, 2] <- round(fit.tab[1:7, 2], 3)

return(fit.tab)
}