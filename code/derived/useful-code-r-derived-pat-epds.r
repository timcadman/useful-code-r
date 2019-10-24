################################################################################
## Project: useful-code-r
## Script purpose: Derive paternal EPDS variables
## Date: 15th October 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

library(alspac)
library(dplyr)

source("./useful-code-r/code/functions/proRate.R")

data(current)

################################################################################
# 1. Define variables  
################################################################################
pb.vars <- "pb260"
pc.vars <- "pc102"
pd.vars <- "pd200"
pe.vars <- "pe290"

pf.vars <- c("pf4030", "pf4031", "pf4032", "pf4033", "pf4034", "pf4035", 
	         "pf4036", "pf4037", "pf4038", "pf4039")

ph.vars <- c("ph3030", "ph3031", "ph3032", "ph3033", "ph3034", "ph3035", 
	         "ph3036", "ph3037", "ph3038", "ph3039")

pj.vars <- c("pj2010", "pj2011", "pj2012", "pj2013", "pj2014", "pj2015", 
	         "pj2016", "pj2017", "pj2018", "pj2019")

pl.vars <- c("pl6060", "pl6061", "pl6062", "pl6063", "pl6064", "pl6065", 
	         "pl6066", "pl6067", "pl6068", "pl6069")

pp.vars <- c("pp4010", "pp4011", "pp4012", "pp4013", "pp4014", "pp4015", 
	         "pp4016", "pp4017", "pp4018", "pp4019")

age.vars <- c("pb900", "pc992", "pd992", "pe990", "pf9991a", "ph9991a", 
	          "pj9991a", "pl9991a", "pp9991a")

extract.vars <- c(pb.vars, pc.vars, pd.vars, pe.vars, pf.vars, ph.vars,
	              pj.vars, pl.vars, pp.vars, age.vars)


################################################################################
# 2. Extract variables  
################################################################################
current.vars <-  subset(current, name %in% extract.vars)

## ---- Extract variables ------------------------------------------------------
pat_epds.mastdata <- extractVars(current.vars)


################################################################################
# 3. Set missing  
################################################################################
pat_epds.mastdata %<>% mutate_if(is.numeric, list(~ifelse(. < 0, NA, .)))

pat_epds.data <- pat_epds.mastdata

################################################################################
# 4. Correctly score  
################################################################################

## ---- Normally scored --------------------------------------------------------
normal.vars <- c("pf4030", "pf4031", "pf4033", "ph3030", "ph3031", "ph3033", 
	             "pj2010", "pj2011", "pj2013", "pl6060", "pl6061", "pl6063", 
	             "pp4010", "pp4011", "pp4013")

pat_epds.data %<>%
mutate_at(vars(normal.vars), list(~ . - 1))

## ---- Reverse scored ---------------------------------------------------------
reverse.vars <- c("pf4032", "pf4034", "pf4035", "pf4036", "pf4037", "pf4038", 
	              "pf4039", "ph3032", "ph3034", "ph3035", "ph3036", 
	              "ph3037", "ph3038", "ph3039", "pj2012", "pj2014", 
	              "pj2015", "pj2016", "pj2017", "pj2018", "pj2019", 
	              "pl6062", "pl6064", "pl6065", "pl6066", "pl6067", "pl6068", 
	              "pl6069", "pp4014", "pp4015", "pp4016", "pp4017", "pp4018", 
	              "pp4019")

pat_epds.data %<>%
mutate_at(vars(reverse.vars), list(~ 4 - .))


################################################################################
# 5. Add up  
################################################################################
pat_epds.data %<>%
mutate(epds_pat_t1 = pb260,
       epds_pat_t2 = pc102,
       epds_pat_t3 = pd200,
       epds_pat_t4 = pe290,
       epds_pat_t5 = proRate(pat_epds.data, pf.vars, 0),
       epds_pat_t6 = proRate(pat_epds.data, ph.vars, 0),
       epds_pat_t7 = proRate(pat_epds.data, pj.vars, 0),
       epds_pat_t8 = proRate(pat_epds.data, pl.vars, 0),
       epds_pat_t9 = proRate(pat_epds.data, pp.vars, 0))


################################################################################
# 6. Create age variables  
################################################################################

# Note t1 variable is gestational age

pat_epds.data %<>%
mutate(epds_pat_age_t1 = pb900,
       epds_pat_age_t2 = pc992 / 4.3481,
       epds_pat_age_t3 = pd992,
       epds_pat_age_t4 = pe990,
       epds_pat_age_t5 = pf9991a,
       epds_pat_age_t6 = ph9991a,
       epds_pat_age_t7 = pj9991a,
       epds_pat_age_t8 = pl9991a,
       epds_pat_age_t9 = pp9991a)


################################################################################
# 7. Keep required variables  
################################################################################
pat_epds.data %<>%
dplyr::select(aln, qlet, epds_pat_t1 : epds_pat_t9, 
	          epds_pat_age_t1 : epds_pat_age_t9)