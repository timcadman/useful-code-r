################################################################################
## Project: useful-code-r
## Script purpose: Deriving paternal covariates 
## Date: 7th March 2019
## Author: Tim Cadman 
## Email: t.cadman@bristol.ac.uk
################################################################################

# R script to create commonly used maternal covariates for analysis using ALSPAC data.
# Requires that source variables are already in the dataset. 
#
# 	(i)	Naming convention. All paternal variables given suffix _pat
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
pat_cov.varlist <- subset(current, name %in% c("pb184", "pc224", "pd244", 
	"pm2024", "pp5024", "pc996", "pb100", "pb078", "pc102", "pc222a", "pd242a", 
	"pe322a", "pf5022", "c_sc_ptnr_pp", "c666a"))

pat_cov_mast.data <- extractVars(pat_cov.varlist)

pat_cov.data <- pat_cov_mast.data

pat_cov.data <- pat_cov.data %>%
  mutate_if(is.numeric, funs(ifelse( . < 0 | . == 9, NA, .)))

################################################################################
# 2. Derive variables  
################################################################################

## ---- Socioeconomic ----------------------------------------------------------
pat_cov.data <- pat_cov.data %>%
mutate(
	pat_sclass = factor(
		           ifelse(c_sc_ptnr_pp <= 2, 0, 1),
		           labels = c("High: Professional, Managerial and Technical",
		           	          "Low: Non-manual, partly and unskilled")),
    pat_ed = factor(
    	       ifelse(c666a <= 3, 1, 0),
    	       labels = c("Low: CSE, vocational or O-level",
    	       	          "High: A-level or Degree")),
    pat_finprob = ifelse(pb184 <= 4, 1, 0),
    pat_finprob2 = ifelse(pc224 <= 4, 1, 0),
    pat_finprob8 = ifelse(pd244 <= 4, 1, 0),
    pat_finprob_early = factor(
    	                  ifelse(pat_finprob == 1 | pat_finprob2 == 1 | 
    	                  	     pat_finprob8 == 1, 1, 0),
                          labels = c("No financial problems", "Financial problems")),
    pat_finprob110 = ifelse(pm2024 <= 3, 1, 0),
    pat_finprob134 = ifelse(pp5024 <= 3, 1, 0),
    pat_finprob_late = factor(
    	                 ifelse(pat_finprob110 == 1 | pat_finprob134 == 1, 1, 0),
    	                 labels = c("No financial problems", "Financial problems")))

## ---- Perinatal---------------------------------------------------------------
pat_cov.data <- pat_cov.data %>%
mutate(
	pat_age = pc996,
	pat_drinkpreg = factor(
		              ifelse(pb100 == 1, 0, 1),
		              labels = c("No", "Yes")),
	pat_smokepreg = factor(
		              ifelse(pb078 == 0, 0, 1),
		              labels = c("No", "Yes")),
	pat_epds_pre = pc102,
    pat_epds_pre_b = factor(
    	               ifelse(pat_epds_pre <= 12, 0, 1),
    	               labels = c("Below depression cut-off", "Above depression cut-off")),
    pat_epds_post = pc102, 
    pat_epds_post_b = factor(
    	                ifelse(pat_epds_post <= 12, 0, 1),
    	                labels = c("Below depression cut-off", "Above depression cut-off")))

## ---- Other risk factors -----------------------------------------------------
pat_cov.data <- pat_cov.data %>%
mutate(
	pat_physpart = factor(
		             ifelse(pc222a == 1 | pd242a == 1 | pe322a == 1 | pf5022 == 1 | 
                            pf5022 == 2 | pf5022 == 3 | pf5022 == 4, 1, 0),
		             labels = c("No", "Yes")))

################################################################################
# 3. Drop original variables  
################################################################################
pat_cov.data <- pat_cov.data %>%
select(aln, pat_sclass, pat_ed, pat_finprob_early, pat_finprob_late, 
	   pat_age, pat_drinkpreg, pat_smokepreg, pat_epds_pre, pat_epds_pre_b,
       pat_epds_post, pat_epds_post_b, pat_physpart)