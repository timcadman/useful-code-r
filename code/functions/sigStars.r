sig_stars <- function(pvals){
  if(pvals <= 0.001){
    star = "***"
  } else if (pvals <= 0.01){
    star = "**"
  } else if (pvals <= 0.05){
    star = "*"
  } else {
    star = ""
  }
  star
}