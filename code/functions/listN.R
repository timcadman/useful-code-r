################################################################################
## Project: useful-code-r
## Script purpose: Create a list and use object names as names
## Date: 13th August 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Took this from a stack overflow answer
# https://stackoverflow.com/questions/18861772/r-get-objects-names-from-the-list-of-objects

listN <- function(...) {
  names <- as.list(substitute(list(...)))[-1L]
  setNames(list(...), names)
}