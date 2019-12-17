################################################################################
## Project: useful-code-r
## Script purpose: Create table of original vs imputed descriptives		
## Date: 28th August 2019	
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Arguments:
#
# imputed = .mids imputed dataset
# vars = vector of variable names
# labs = reference dataframe containing names and variables. Columns must be
#        labelled "name" and "label"
#
# Output: a list containing (i) percent imputed for each variable, (ii)
# descriptive statistics of original and imputed variables.

require(labelled)
require(dplyr)
require(mice)
require(magrittr)
require(tableone)

source("./useful-code-r/code/functions/match-lab.r")

descImp <- function(imputed, vars, labs = NULL, factvars = NULL, format = "p"){

## ---- Rename variable indicating original dataset ----------------------------
imputed %<>%
mutate(source = ifelse(imputed$.imp == 0, "original", "imputed")) %>%
dplyr::select(vars, source, -.imp)

## ---- Set variable labels ----------------------------------------------------
var_label(imputed) <- matchLab(reflabel = labs$lab, 
	                        refname = labs$name, 
	                        targname = colnames(imputed))

## ---- Percentage imputed -----------------------------------------------------
out <- list()

out[[1]] <- imputed %>%
filter(source == "original") %>%
dplyr::select(-source) %>%
sapply(., function(x) (length(x) - sum(!is.na(x))) / length(x))

## ---- Original vs imputed descriptives ---------------------------------------
tmp <- CreateTableOne(data = imputed, 
                      strata = "source",
                      includeNA = FALSE,
                      factorVars = factvars)

out[[2]] <- print(tmp, quote = FALSE, 
                       noSpaces = TRUE, 
                       printToggle = FALSE,
                       format = format,
                       test = FALSE,
                       varLabels = TRUE)

names(out) <- c("Percent imputed", "Descriptives")

return(out)
}