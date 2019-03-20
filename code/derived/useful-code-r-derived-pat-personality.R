 ################################################################################
## Project: useful-code-r
## Script purpose: Derive summary variables for paternal personality
## Date: 7th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# This file creates summary variables for paternal maladaptive 
# personality traits as measured by the Karolinska Scales of Personality.
# Quartiles are calculated for each domain of personality and two summary 
# variables are created:
#
# mat_pers_symp = number of domains participant scores in top quartile
# mat_pers_bin = binary version of above indicating whether participant scored 
# in top quartile in >=3 domains.
#
# Further details can be found in:
#
# Pearson, R., Campbell, A., Howard, L., Bornstein, M., O'Mahen, H., Mars, B., 
# & Moran, P. (2018). Impact of dysfunctional maternal personality traits on 
# risk of offspring depression, anxiety and self-harm at age 18 years: A 
# population-based longitudinal study. Psychological Medicine, 48(1), 50-60. 
# doi:10.1017/S0033291717001246
#
# IMPORTANT NOTE:
# The items included in each domain differ from the categorisation in the 
# original validation paper (https://www.oru.se/globalassets/oru-sv/forskning/
# forskningsprojekt/jps/kriminologi/ida-rapporter/ida-report-no-64.pdf)
# All domains related to neuroticism were removed, and other amendments based on 
# (unpublished) factor analysis. Thus this script only produces variables based 
# on 5 domains of personality
#

library(alspac)
library(dplyr)
library(Hmisc)

source("./useful-code-r/code/functions/proRate.R")
source("./useful-code-r/code/functions/stataQuant.R")

data(current)
################################################################################
#  # 1. Get variables  
################################################################################
pat_pers.varlist <- subset(current, name %in% c("pm5014", "pm5015", "pm5018", 
	"pm5034", "pm5042", "pm5086", "pm5094", "pm5122", "pm5125", "pm5128", 
	"pm5024", "pm5037", "pm5051", "pm5077", "pm5081", "pm5091", "pm5104", 
	"pm5117", "pm5118", "pm5126", "pm5100", "pm5080", "pm5079", "pm5047", 
	"pm5029", "pm5019", "pm5007", "pm5001", "pm5009", "pm5021", "pm5027", 
	"pm5043", "pm5053", "pm5072", "pm5076", "pm5101", "pm5108", "pm5129", 
	"pm5011", "pm5023", "pm5044", "pm5054", "pm5070", "pm5084", "pm5102", 
	"pm5106", "pm5113"))

pat_pers_mast.data <- extractVars(pat_pers.varlist, adult_only = TRUE)

pat_pers.data <- pat_pers_mast.data

################################################################################
# 2. Create variable lists  
################################################################################
pat_ang.varlist <- c("pm5014", "pm5015", "pm5018", "pm5034", "pm5042", "pm5086", 
	                 "pm5094", "pm5122", "pm5125", "pm5128")

pat_detach.varlist <- c("pm5024", "pm5037", "pm5051", "pm5077", "pm5081", 
	                 "pm5091", "pm5104", "pm5117", "pm5118")

pat_imp.varlist <- c("pm5126", "pm5100", "pm5080", "pm5079", "pm5047", "pm5029", 
	                 "pm5019", "pm5007")

pat_monav.varlist <- c("pm5001", "pm5009", "pm5021", "pm5027", "pm5043", 
					   "pm5053", "pm5072", "pm5076", "pm5101", "pm5108", 
					   "pm5129")

pat_sup.varlist <- c("pm5011", "pm5023", "pm5044", "pm5054", "pm5070", "pm5084", 
	                 "pm5102", "pm5106", "pm5113")

################################################################################
# 3. Set to missing and recode where reverse scored  
################################################################################
pat_pers.data <- pat_pers.data %>%
mutate_if(is.numeric, funs(ifelse( . < 0, NA, .)))

pat_pers.data <- pat_pers.data %>%
mutate_at(vars(pm5014, pm5015, pm5024, pm5019, pm5021, pm5011, pm5106),
	funs(5 -.))

################################################################################
# 4. Derive intermediate variables  
################################################################################

## ---- Subscale totals --------------------------------------------------------
pat_pers.data <- pat_pers.data %>%
mutate(pat_ang_tot = ifelse(is.na(pm5014), NA,
  	            	rowSums(select(., pat_ang.varlist), na.rm = TRUE)),
       pat_detach_tot = ifelse(is.na(pm5024), NA,
       	            rowSums(select(., pat_detach.varlist), na.rm = TRUE)),
       pat_imp_tot = ifelse(is.na(pm5126), NA, 
       				rowSums(select(., pat_imp.varlist), na.rm = TRUE)),
       pat_monav_tot = ifelse(is.na(pm5001), NA, 
       				rowSums(select(., pat_monav.varlist), na.rm = TRUE)),
       pat_sup_tot = ifelse(is.na(pm5011), NA, 
       				rowSums(select(., pat_sup.varlist), na.rm = TRUE)))


## ---- Variable indicating which quartile subject is in for each subscale -----
pat_pers.data <- pat_pers.data %>%
mutate(
  pat_ang_quart =    stataQuant(pat_pers.data$pat_ang_tot, 4),
  pat_detach_quart = stataQuant(pat_pers.data$pat_detach_tot, 4),
  pat_imp_quart =    stataQuant(pat_pers.data$pat_imp_tot, 4),
  pat_monav_quart =  stataQuant(pat_pers.data$pat_monav_tot, 4),
  pat_sup_quart =    stataQuant(pat_pers.data$pat_sup_tot, 4))

## ---- Final summary variables ------------------------------------------------	
pat_pers.data <- pat_pers.data %>%
mutate(pat_pers_symp = ifelse(is.na(pat_sup_tot), NA, 
						rowSums(select(pat_pers.data, pat_ang_quart, 
	                                  pat_detach_quart, pat_imp_quart, 
	                                  pat_monav_quart, pat_sup_quart) == 4, 
								na.rm = TRUE)),
	  pat_pers_symp = ifelse(pat_pers_symp >= 3, 3, pat_pers_symp), # Cap at 3
	  pat_pers_bin = factor(
	  	               ifelse(pat_pers_symp >= 3, 1, 0),
	  	               labels = c("Low maladpative personality", 
	  	               	"High maladaptive personality")))

Hmisc::describe(pat_pers.data$pat_pers_bin)

################################################################################
# 5. Drop temporary variables  
################################################################################
pat_pers.data <- pat_pers.data %>%
select(aln, pat_pers_symp, pat_pers_bin)

save(pat_pers.data, file = "z:/projects/ieu2/p6/021/working/data/pat_pers.RData")