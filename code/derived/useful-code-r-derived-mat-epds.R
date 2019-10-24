################################################################################
## Project: useful-code-r
## Script purpose: Score Maternal EPDS questionnaires
## Date: 11th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# The STATA version of this script was originally written by Rebecca Pearson -
# I have simply converted to R code.

################################################################################
# 1. Get variables  
################################################################################
mat_epds.varlist <- subset(current, name %in% c("b360", "b361", "b362", "b363", 
	"b364", "b365", "b366", "b367", "b368", "b369", "c590", "c591", "c592", 
	"c593", "c594", "c595", "c596", "c597", "c598", "c599", "e380", "e381", 
	"e382", "e383", "e384", "e385", "e386", "e387", "e388", "e389", "f190", 
	"f191", "f192", "f193", "f194", "f195", "f196", "f197", "f198", "f199", 
	"g280", "g281", "g282", "g283", "g284", "g285", "g286", "g287", "g288", 
	"g289", "g290", "h190", "h191", "h192", "h193", "h194", "h195", "h196", 
	"h197", "h198", "h199", "h200a", "k3030", "k3031", "k3032", "k3033", 
	"k3034", "k3035", "k3036", "k3037", "k3038", "k3039", "l2010", "l2011", 
	"l2012", "l2013", "l2014", "l2015", "l2016", "l2017", "l2018", "l2019",	
	"n6060", "n6061", "n6062", "n6063", "n6064", "n6065", "n6066", "n6067", 
	"n6068", "n6069", "r4010", "r4011", "r4012", "r4013", "r4014", "r4015", 
	"r4016", "r4017", "r4018", "r4019", "r4130"))

mat_epds_mast.data <- extractVars(mat_epds.varlist, adult_only = TRUE)

mat_epds.data <- mat_epds_mast.data

################################################################################
# 2. Create variable lists  
################################################################################

mat_epds_b.varlist <- c("b360", "b361", "b362", "b363", "b364", "b365", "b366", 
                        "b367", "b368", "b369")

mat_epds_c.varlist <- c("c590", "c591", "c592", "c593", "c594", "c595", "c596", 
	                    "c597", "c598", "c599")

mat_epds_e.varlist <- c("e380", "e381", "e382", "e383", "e384", "e385", "e386", 
	                    "e387", "e388", "e389")

mat_epds_f.varlist <- c("f190",	"f191", "f192", "f193", "f194", "f195", "f196", 
	                    "f197", "f198", "f199")

mat_epds_g.varlist <- c("g280", "g281", "g282", "g283", "g284", "g285", "g286", 
	                    "g287", "g288", "g289")

mat_epds_h.varlist <- c("h190", "h191", "h192", "h193", "h194", "h195", "h196", 
                        "h197", "h198", "h199")

mat_epds_k.varlist <- c("k3030", "k3031", "k3032", "k3033", "k3034", "k3035", 
	                    "k3036", "k3037", "k3038", "k3039")

mat_epds_l.varlist <- c("l2010", "l2011", "l2012", "l2013", "l2014", "l2015", 
                        "l2016", "l2017", "l2018", "l2019")

mat_epds_n.varlist <- c("n6060", "n6061", "n6062", "n6063", "n6064", "n6065", 
	                    "n6066", "n6067", "n6068", "n6069")

mat_epds_r.varlist <- c("r4010", "r4011", "r4012", "r4013", "r4014", "r4015", 
	                    "r4016", "r4017", "r4018", "r4019")


################################################################################
# 3. Set to missing and recode
################################################################################
mat_epds.data <- mat_epds.data %>%
mutate_if(is.numeric, funs(ifelse(. < 0, NA, .)))

## ---- Coded 1 higher than they should be -------------------------------------
mat_epds.data <- mat_epds.data %>%
mutate_at(vars("b360", "b361", "b363", "c590", "c591", "c593", "e380", "e381", 
	"e383", "f190",	"f191", "f193", "g280", "g281", "g283", "h190", "h191", 
	"h193", "k3030", "k3031", "k3033", "l2010", "l2011", "l2013", "n6060", 
	"n6061", "n6063", "r4010", "r4011", "r4013"), funs(. - 1))

## ---- Reverse-score -----------------------------------------------------------
mat_epds.data <- mat_epds.data %>%
mutate_at(vars("b362", "b364", "b365", "b366", "b367", "b368", "b369", "c592", 
	"c594", "c595", "c596", "c597", "c598", "c599", "e382", "e384", "e385", 
	"e386", "e387", "e388", "e389", "f192", "f194", "f195", "f196", "f197", 
	"f198", "f199", "g282", "g284", "g285", "g286", "g287", "g288", "g289",
	"h192", "h194", "h195", "h196", "h197", "h198", "h199", "k3032", "k3034", 
	"k3035", "k3036", "k3037", "k3038", "k3039", "l2012", "l2014", "l2015", 
	"l2016", "l2017", "l2018", "l2019", "n6062", "n6064", "n6065", "n6066", 
	"n6067", "n6068", "n6069", "r4012", "r4014", "r4015", "r4016", "r4017", 
	"r4018", "r4019"), funs(4 - .))

################################################################################
# 4. Create summary scores  
################################################################################
mat_epds.data <- mat_epds.data %>%
mutate(
	mat_epds_b_sum = proRate(mat_epds.data, mat_epds_b.varlist, 0),
	mat_epds_c_sum = proRate(mat_epds.data, mat_epds_c.varlist, 0),
	mat_epds_e_sum = proRate(mat_epds.data, mat_epds_e.varlist, 0),
	mat_epds_f_sum = proRate(mat_epds.data, mat_epds_f.varlist, 0),
	mat_epds_g_sum = proRate(mat_epds.data, mat_epds_g.varlist, 0),
	mat_epds_h_sum = proRate(mat_epds.data, mat_epds_h.varlist, 0),
	mat_epds_k_sum = proRate(mat_epds.data, mat_epds_k.varlist, 0),
	mat_epds_l_sum = proRate(mat_epds.data, mat_epds_l.varlist, 0),
	mat_epds_n_sum = proRate(mat_epds.data, mat_epds_n.varlist, 0),
	mat_epds_r_sum = proRate(mat_epds.data, mat_epds_r.varlist, 0),
	mat_epds_b_bin = factor(
		                ifelse(mat_epds_b_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_c_bin = factor(
		                ifelse(mat_epds_c_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_e_bin = factor(
		                ifelse(mat_epds_e_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_f_bin = factor(
		                ifelse(mat_epds_f_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_g_bin = factor(
		                ifelse(mat_epds_g_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_h_bin = factor(
		                ifelse(mat_epds_h_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_k_bin = factor(
		                ifelse(mat_epds_k_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_l_bin = factor(
		                ifelse(mat_epds_l_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_n_bin = factor(
		                ifelse(mat_epds_n_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_r_bin = factor(
		                ifelse(mat_epds_r_sum > 12, 1, 0),
		                labels = c("Below cut-off", "Above cut-off")),
	mat_epds_preg_av = (mat_epds_b_sum + mat_epds_c_sum) / 2,
	mat_epds_post_av = (mat_epds_e_sum + mat_epds_f_sum) / 2,
	mat_epds_presch_av = (mat_epds_g_sum + mat_epds_h_sum) / 2,
	mat_epds_sch_av = (mat_epds_k_sum + mat_epds_l_sum + mat_epds_n_sum +
	                   mat_epds_r_sum) / 4,
	mat_epds_life_av = mat_epds_presch_av + mat_epds_sch_av)
	
################################################################################
# 5. Drop original variables  
################################################################################
mat_epds.data <- mat_epds.data %>%
dplyr::select(aln, mat_epds_b_sum, mat_epds_c_sum, mat_epds_e_sum, mat_epds_f_sum,
	mat_epds_g_sum, mat_epds_h_sum, mat_epds_k_sum, mat_epds_l_sum, 
	mat_epds_n_sum, mat_epds_r_sum, mat_epds_b_bin, mat_epds_c_bin, 
	mat_epds_e_bin, mat_epds_f_bin, mat_epds_g_bin, mat_epds_h_bin, 
	mat_epds_k_bin, mat_epds_l_bin, mat_epds_n_bin, mat_epds_r_bin, 
	mat_epds_preg_av, mat_epds_post_av, mat_epds_presch_av, mat_epds_sch_av, 
	mat_epds_life_av)