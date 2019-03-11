################################################################################
## Project: useful-code-r
## Script purpose: Deriving child covariates
## Date: 7th March 2019
## Author: Tim Cadman 
## Email: t.cadman@bristol.ac.uk
################################################################################

# R script to create commonly used child covariates for analysis using ALSPAC data.
# Requires that source variables are already in the dataset. 
#
# All values <0 set to NA at the beginning of the script

library(alspac)
library(dplyr)
library(Hmisc)

data(current)
################################################################################
# 1. Get data 
################################################################################
chi_cov.varlist <- subset(current, name %in% c("kz021", "c804", "kc404", "kc760",
	               "kc761", "kc762", "kc763", "kc764", "kc765", "kc766", "kc767"))

chi_cov_mast.data <- extractVars(chi_cov.varlist)

chi_cov.data <- chi_cov_mast.data

################################################################################
# 2. Set missing  
################################################################################
chi_cov.data <- chi_cov.data %>%
  mutate_if(is.numeric, funs(ifelse( . < 0 | . == 9, NA, .)))

################################################################################
# 3. Derive variables
################################################################################
chi_cov.data <- chi_cov.data %>%
mutate(
	sex = factor(kz021, 
		    labels = c("Male", "Female")), #Sex
	ethnicity = factor(c804, 
		    labels = c("White", "Non-white")),
    breastfed = factor(
    	          ifelse(kc404 == 0, 1, 0),
    	          labels = c("Yes", "No")),
    mat_childcare = factor(
	              ifelse(kc760 == 2 | kc761 ==2 | kc762 ==2 | kc763 ==2 |
		                 kc764 ==2 | kc765 ==2 | kc766 ==2 | kc767 ==2, 0, 1),
	              labels = c("Childcare available", "No childcare available")))

################################################################################
# 3. Drop original variables   
################################################################################
chi_cov.data <- chi_cov.data %>%
select(aln, qlet, sex, ethnicity, breastfed, mat_childcare)