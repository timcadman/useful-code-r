################################################################################
## Project: useful-code-r
## Script purpose: Perform QC for MLM
## Date: 8th October 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################
 

mlmQC <- function(long_data, type, age, occasion, outcome){

## Remove missing, create variable indicating number of valid data points per 
## subject
long_data %<>%
dplyr::filter(!is.na(!!sym(outcome))) %>%
dplyr::group_by(id) %>%
dplyr::mutate(count = n())

## Generate variable indicating difference in age between previous occasion
long_data %<>%
dplyr::group_by(id) %>%
dplyr::arrange(occasion) %>%
dplyr::mutate(prev = age - lag(age))

if(type == "display"){

cat("", "1. Number of valid cases at each age", sep="\n\n")

table(long_data$occasion) %>%
print()

cat("", "2. Number of valid observations per subject", sep="\n\n")

table(long_data$count) %>%
print()

cat("", "3. Number of cases where age appears to decrease between observations", 
	sep="\n\n")

long_data %>%
dplyr::filter(prev <= 0) %>%
dplyr::arrange(prev) %>%
head(., 200)

}

else if(type == "delete"){

## Remove individuals with <= 1 observation
long_data %<>%
dplyr::filter(count > 1)

## Delete observations which show a negative age progression between occassions
#long_data %<>%
#dplyr::filter(prev > 0)

## Ungroup
long_data %<>%
ungroup()

return(long_data)

}

}