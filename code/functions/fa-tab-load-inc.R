################################################################################
## Project: useful-code-r
## Script purpose: To make a table of item factor loadings
## Date: 6th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Takes as arguments (i) fa object, (ii) cut-off threshold and (iii) variable 
# labels

faTabLoadInc <- function(object, labels, cutoff){

load_tmp <- data.frame(matrix(as.numeric(object$loadings), #put loadings in data frame
	attributes(object$loadings)$dim, 
	dimnames = attributes(object$loadings)$dimnames))

load_tmp <- tibble::rownames_to_column(load_tmp)

# Pretty hacky way of subsetting based on cutoff
load_tmp$min <- apply(load_tmp[, 2:(nfact + 1)], 1, min)
load_tmp$max <- apply(load_tmp[, 2:(nfact + 1)], 1, max)
load_tmp$above <- ifelse(load_tmp$max >= cutoff | load_tmp$min <= -cutoff, 1, 0)

load_above <- subset(load_tmp, load_tmp$above == 1)
load_above <- round_df(load_above, digits = 2) #round to 2 digits

load <- load_above %>%
mutate_all(funs(ifelse(. <= cutoff & . >= -cutoff, "", .))) #make everything below cutoff blank

labs <- labels$lab[match(as.character(load$rowname), as.character(labels$name))]

load_facts <- load[, 2:(nfact + 1)] #dataframe with factor loadings

load_out <- data.frame(load$rowname, labs, load_facts[, order(names(load_facts))]) #put all together, but sorting the factors into alphabetical order

## ---- Sort out variable labels -------------------------------------------------------------------

col_fact_names <- vector(length = nfact)

for(i in 1:nfact){
col_fact_names[[i]] <- paste("Factor", i)
}

col_var_names<- c("Variable name", "Variable label")

colnames(load_out) <- c(col_var_names, col_fact_names)

return(load_out)

}