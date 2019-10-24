################################################################################
## Project: useful-code-r
## Script purpose: Combine original and imputed data to explore distributions		
## Date: 28th August 2019	
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# This function combines the original dataframe with the imputed dataframes. 
# Vars argument takes a vector of variable names to subset. The resulting 
# object can then be fed to a function to produce descriptives, grouping by
# "source"

combImp <- function(original, imputed, vars){

imp_coll <- complete(imputed, 1)

for(i in 1: imputed$m){

imp_coll <- rbind(imp_coll, complete(imputed, i+1))

}

orig <- original %>%
select(vars)
orig$source = "original"

imp <- imp_coll %>%
select(vars)
imp$source = "imputed"

comb <- rbind(orig, imp)

}