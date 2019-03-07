################################################################################
## Project: useful-code-r
## Script purpose: Pro-rate questionnaire data
## Date: 7th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################
#
# Arguments:
#
# data: a dataset
# varlist: a list of variables to be pro-rated
# threshold: a threshold of "missingness". If number of items missing is > this
#            threshold then NA will be returned instead of a pro-rated score.

proRate <- function(data, varlist, threshold){
  
if(threshold >= length(varlist)){
	stop("Cannot pro-rate: threshold for missingness is >= number of variables")
}
  sub <- subset(data, select=varlist)
  sub$nmiss <- apply(sub, 1, function(x) sum(is.na(x)))

  sub$meanscore <- ifelse(sub$nmiss <= threshold, rowMeans(sub, na.rm=TRUE), NA)
  sub$totalscore <- sub$meanscore * length(varlist)
  return(as.numeric(sub$totalscore))
  
}