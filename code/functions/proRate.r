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

sub <- subset(data, select=varlist)
  
if(threshold >= length(varlist)){
	stop("Cannot pro-rate: threshold for missingness is >= number of variables")
}
  
else if(threshold == 0){
	sub$totalscore <- rowSums(sub, na.rm=FALSE)
print("Warning: Only complete cases included, total score is sum of items")
return(sub$totalscore)
}

else{
  sub$nmiss <- apply(sub, 1, function(x) sum(is.na(x)))
  sub$meanscore <- ifelse(sub$nmiss <= threshold, 
  	                  rowMeans(
  	                  	 select(sub, varlist), na.rm=TRUE), NA)
  sub$totalscore <- sub$meanscore * length(varlist)
return(as.numeric(sub$totalscore))
}
  
}