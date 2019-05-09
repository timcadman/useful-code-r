################################################################################
## Project: useful-code-r
## Script purpose: Extract variable labels from reference dataframe
## Date: 2nd April 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Arguments
#
# reflabel: Variable label column from reference dataframe
# refname: Variable name column from reference dataframe
# targname: Variable name column from target variable dataframe


matchLab <- function(reflabel, refname, targname){

reflabel[match(as.character(targname), as.character(refname))]

}