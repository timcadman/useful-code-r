################################################################################
## Project: useful-code-r
## Script purpose: Rounds all numeric values in a data frame
## Date: 5th March 2019
## Author: https://stackoverflow.com/questions/9063889/how-to-round-a-data-frame-in-r-that-contains-some-character-variables/9064964
################################################################################

round_df <- function(df, digits) {
  nums <- vapply(df, is.numeric, FUN.VALUE = logical(1))

  df[,nums] <- round(df[,nums], digits = digits)

  (df)
}