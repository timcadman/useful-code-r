################################################################################
## Project: useful-code-r
## Script purpose: Deriving maternal covariates
## Date: 7th March 2019
## Author: Tim Cadman 
## Email: t.cadman@bristol.ac.uk
################################################################################

# R script to create commonly used maternal covariates for analysis using ALSPAC data.
# Requires that source variables are already in the dataset. 
#
# 	(i)	Naming convention. All maternal variables given suffix _mat
#
#	(ii) All values <0 set to NA at the beginning of the script
#
#	(iii) Direction of coding. All binary variables are coded so that the higher risk
#		is "1" and the lower risk "0". So for example high maternal education is coded
#		as "0" and low maternal education coded as "1". This should make interpreation
#		of coefficients easier. 

library(alspac)
library(dplyr)
library(Hmisc)

data(current)
################################################################################
# 1. Get data 
################################################################################
mat_cov.varlist <- subset(current, name %in% c("c645a", "h470", "b_sc_m", "b594", 
	"e424", "f244", "p2024", "r5024", "f306", "f900", "kc760", "b721", "b665", 
	"mz028b", "b032", "b300", "c064", "f242a", "g322a", "h232", "h232a", "d536a", 
	"f593"))

mat_cov_mast.data <- extractVars(cov.varlist)

mat_cov.data <- cov_mast.data

mat_cov.data <- mat_cov.data %>%
  mutate_if(is.numeric, funs(ifelse( . < 0 | . == 9, NA, .)))

################################################################################
# 2. Derive variables  
################################################################################

## ---- Socioeconomic ----------------------------------------------------------
mat_cov.data <- mat_cov.data %>%
mutate(
	mat_ed = factor(
		       ifelse(c645a <= 3, 1, 0), 
	           labels = c("High: A-level or Degree", "Low: CSE, vocational or O-level")),
    income = factor(
    	       ifelse(h470 <= 3, 1, 0),
	           labels = c("High:£300+", "Low: £0 - £299")),
    mat_sclass = factor(
    	           ifelse(b_sc_m <= 2, 0, 1),
	               labels = c("High: Professional, Managerial and Technical", 
		                  "Low: Non-manual, partly unskilled and unskilled")),
    mat_finprob = ifelse(b594 <= 4, 1, 0),
    mat_finprob2 = ifelse(e424 <= 4, 1, 0),
    mat_finprob8 = ifelse(f244 <= 4, 1, 0),
    mat_finprob_early = factor(
	                      ifelse(mat_finprob == 1 | mat_finprob2 == 1 | mat_finprob8 == 1, 1, 0),
	                      labels = c("No financial problems", "Financial problems")),
    mat_finprob110 = ifelse(p2024 <= 3, 1, 0),
    mat_finprob134 = ifelse(r5024 <= 3, 1, 0),
    mat_finprob_late = factor(
	                     ifelse(mat_finprob110 == 1 | mat_finprob134 == 1, 1, 0),
	                     labels = c("No financial problems", "Financial problems")),
    mat_dwell = factor(
    	          ifelse(f306 <= 2, 0, 1),
	              labels = c("Homeowner", "Not homeowner")),
    mat_neighbourhood = factor(
    	                  ifelse(f900 <= 2, 0, 1),
	                      labels = c("Good neighbourhood", "Bad neighbourhood")))    

## ---- Perinatal---------------------------------------------------------------
mat_cov.data <- mat_cov.data %>%
mutate(
	mat_drinkpreg = factor(
		              ifelse(b721 == 1, 0, 1),
		              labels = c("No", "Yes")),
    mat_smokepreg = factor(
    	              ifelse(b665 == 1, 0, 1),
    	              labels = c("No", "Yes")),
    mat_age = mz028b,
    mat_parity = factor(
    	           ifelse(b032 == 0, 0, 1),
    	           labels = c("No previous pregnancies", "Previous pregnancies")),
    mat_intent = factor(
    	           ifelse(b300 == 2, 1, 0),
    	           labels = c("Planned pregnancy", "Unplanned pregnancy")),
    mat_infection = factor(
    	              ifelse(c064 == 1, 1, 0),
    	              labels = c("Infection", "No infection")))

## ---- Other risk factors -----------------------------------------------------
mat_cov.data <- mat_cov.data %>%
mutate(
	mat_physpart = factor(
	                 ifelse(f242a ==1 | g322a ==1 | h232 ==1 | h232a ==1, 1, 0),
	                 labels = c("No", "Yes")),
    gran_hisdep = factor(
       	             ifelse(d536a == 1, 1, 0),
       	             labels = c("No", "Yes")),
    mat_martcon = f593)

################################################################################
# 3. Drop original variables  
################################################################################

mat_cov.data <- mat_cov.data %>%
select(aln, qlet, mat_ed, income, mat_sclass, mat_finprob_early, 
	   mat_finprob_late, mat_dwell, mat_neighbourhood, mat_drinkpreg, mat_smokepreg, 
	   mat_age, mat_parity, mat_intent, mat_infection, mat_physpart, gran_hisdep, 
	   mat_martcon)