################################################################################
## Project: useful-code-r
## Script purpose: Load and Save wrappers
## Date: 6th November 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

dSave <- function(object, dpath = data_path, file){

save(object, file = paste0(dpath, file))	

}

dLoad <- function(file, dpath = data_path){

load(file = paste0(dpath, file), envir=.GlobalEnv)

}