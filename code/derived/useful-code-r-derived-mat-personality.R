################################################################################
## Project: useful-code-r
## Script purpose: Derive summary variables for maternal personality
## Date: 7th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# This file creates summary variables for maternal and paternal maladaptive 
# personality traits as measured by the Karolinska Scales of Personality.
# Quartiles are calculated for each domain of personality and two summary variables are created:
#
# mat_pers_symp = number of domains participant scores in top quartile
# mat_pers_bin = binary version of above indicating whether participant scored in top 
# quartile in >=3 domains.
#
# Further details can be found in:
#
# Pearson, R., Campbell, A., Howard, L., Bornstein, M., O'Mahen, H., Mars, B., & Moran, P. (2018). 
# Impact of dysfunctional maternal personality traits on risk of offspring depression, anxiety and 
# self-harm at age 18 years: A population-based longitudinal study. Psychological Medicine, 48(1), 
# 50-60. doi:10.1017/S0033291717001246
#
# IMPORTANT NOTE:
# The items included in each domain differ from the categorisation in the original
# validation paper (https://www.oru.se/globalassets/oru-sv/forskning/forskningsprojekt/jps/kriminologi/ida-rapporter/ida-report-no-64.pdf)
# All domains related to neuroticism were removed, and other amendments based on (unpublished) factor analysis.
# Thus this script only produces variables based on 5 domains of personality
#
# ANOTHER IMPORTANT NOTE:
#
# This version of the syntax calculates the summary score slightly different than
# the original Stata version. In that version the missingness rule for subscale
# sum scores was quite lax: missing was treated as 0, with the variable set at 
# 0 if they were missing on one particular item from the subcale. By contrast, 
# here I prorate the subscales (with a maximum missing of 3). The end result is
# a slightly lower amount of parents in the 'maladaptive personality' group: I 
# presume that this is because using the other missingness rule there was an
# increase of low scores, thus the cutpoint for the top quartile was lower.

library(alspac)
library(dplyr)
library(Hmisc)
library(readstata13)

source("./useful-code-r/code/functions/proRate.R")
source("./useful-code-r/code/functions/stataQuant.R")


data(current)

################################################################################
# 1. Get variables  
################################################################################
mat_pers.varlist <- subset(current, name %in% c("p5014", "p5015", "p5018", "p5034", 
	                       "p5042", "p5094", "p5122", "p5125", "p5128", "p5086", 
	                       "p5024", "p5037", "p5051", "p5081", "p5091", "p5104", 
	                       "p5118", "p5117", "p5077", "p5019", "p5079", "p5007", 
	                       "p5029", "p5048", "p5080", "p5100", "p5126", "p5001",
	                       "p5009", "p5021", "p5027", "p5043", "p5053", "p5072", 
	                       "p5076", "p5101", "p5108", "p5129", "p5011", "p5023", 
	                       "p5044", "p5054", "p5070", "p5084", "p5102", "p5106", 
	                       "p5113"))

mat_pers_mast.data <- extractVars(mat_pers.varlist)

mat_pers.data <- mat_pers_mast.data

################################################################################
# 2. Create variable lists  
################################################################################
mat_ang.varlist <- c("p5015", "p5014", "p5018", "p5034", "p5042", "p5094", "p5122", 
	             "p5125", "p5128", "p5086")

mat_detach.varlist <- c("p5024", "p5037", "p5051", "p5081", "p5091", "p5104", "p5118", 
	                "p5117", "p5077")

mat_imp.varlist <- c("p5007", "p5029", "p5048", "p5080", "p5100", "p5126", "p5019", 
	             "p5079")

mat_monav.varlist <- c("p5001", "p5009", "p5021", "p5027", "p5043", "p5053", "p5072",
	                   "p5076", "p5101", "p5108", "p5129")

mat_sup.varlist <- c("p5011", "p5023", "p5044", "p5054", "p5070", "p5084", "p5102",
	                 "p5106", "p5113")

################################################################################
# 3. Set to missing and recode where reverse scored  
################################################################################
mat_pers.data <- mat_pers.data %>%
mutate_if(is.numeric, funs(ifelse( . < 0, NA, .)))

mat_pers.data <- mat_pers.data %>%
mutate_at(vars(p5014, p5015, p5042, p5024, p5019, p5079, p5021, p5011, p5106),
	      funs(5 -.))

################################################################################
# 4. Derive intermediate variables  
################################################################################

## ---- Subscale totals --------------------------------------------------------
mat_pers.data <- mat_pers.data %>%
mutate(
  mat_ang_tot = proRate(mat_pers.data, mat_ang.varlist, 3),
  mat_detach_tot = proRate(mat_pers.data, mat_detach.varlist, 3),
  mat_imp_tot = proRate(mat_pers.data, mat_imp.varlist, 3),
  mat_monav_tot = proRate(mat_pers.data, mat_monav.varlist, 3),
  mat_sup_tot = proRate(mat_pers.data, mat_sup.varlist, 3))

## ---- Variable indicating which quartile subject is in for each subscale -----
mat_pers.data <- mat_pers.data %>%
mutate(
  mat_ang_quart =    stataQuant(mat_pers.data$mat_ang_tot, 4),
  mat_detach_quart = stataQuant(mat_pers.data$mat_detach_tot, 4),
  mat_imp_quart =    stataQuant(mat_pers.data$mat_imp_tot, 4),
  mat_monav_quart =  stataQuant(mat_pers.data$mat_monav_tot, 4),
  mat_sup_quart =    stataQuant(mat_pers.data$mat_sup_tot, 4))

## ---- Final summary variables ------------------------------------------------
mat_pers.data <- mat_pers.data %>%
mutate(mat_pers_symp = 
	rowSums(select(mat_pers.data, mat_ang_quart, mat_detach_quart, mat_imp_quart, 
		mat_monav_quart, mat_sup_quart) == 4),
	  mat_pers_symp = ifelse(mat_pers_symp >= 3, 3, mat_pers_symp), # Cap at 3
	  mat_pers_bin = factor(
	  	               ifelse(mat_pers_symp >= 3, 1, 0),
	  	               labels = c("Low maladpative personality", 
	  	               	"High maladaptive personality")))

################################################################################
# 5. Drop temporary variables  
################################################################################








mat_pers.data <- mat_pers.data %>%
select(aln, mat_pers_symp, mat_pers_bin)

save(mat_pers.data, file = "z:/projects/ieu2/p6/021/working/data/mat_per.RData")

test <- read.dta13("test.dta")

testy <- stataQuant(test$ksp_ang, 4)

table(testy)