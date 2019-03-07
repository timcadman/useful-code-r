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

################################################################################
# 1. Get variables  
################################################################################
mat_pers.varlist <- subset(current, name %in% c("p5014", "p5015", "p5018", "p5034", 
	                       "p5042", "p5094", "p5122", "p5125", "p5128", "p5086", 
	                       "p5024", "p5037", "p5051", "p5081", "p5091", "p5104", 
	                       "p5118", "p5117", "p5077", "p5019", "p5079", "p5007", 
	                       "p5029", "p5048", "p5080", "p5100", "p5126", "p5001",
	                       "p5009", "p5021", "p5027", "p5043", "p5072", "p5076", 
	                       "p5101", "p5108", "p5129", "p5011", "p5023", "p5044",
	                       "p5070", "p5084", "p5102", "p5106", "p5113"))

mat_pers_mast.data <- extractVars(mat_pers.varlist)

mat_pers.data <- mat_pers_mast.data


################################################################################
# 2. Create variable lists  
################################################################################
ang.varlist <- c("p5015", "p5014", "p5018", "p5034", "p5042", "p5094", "p5122", 
	             "p5125", "p5128", "p5086")

detach.varlist <- c("p5024", "p5037", "p5051", "p5081", "p5091", "p5104", "p5118", 
	                "p5117", "p5077")

imp.varlist <- c("p5007", "p5029", "p5048", "p5080", "p5100", "p5126", "p5019", 
	             "p5079")

monav.varlist <- c("p5001", "p5009", "p5021", "p5043", "p5053", "p5076", "p5101", 
	               "p5108", "p5129")

sup.varlist <- c("p5011", "p5023", "p5044", "p5054", "p5070", "p5084", "p5106", 
	             "p5113")

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
ang_tot <- proRate(mat_pers.data, ang.varlist, 0)
ang_detach <- proRate(mat_pers.data, detach.varlist, 0)
ang_imp <- proRate(mat_pers.data, imp.varlist, 0)
ang_monav <- proRate(mat_pers.data, monay.varlist, 0)
ang_sup <- proRate(mat_pers.data, sup.varlist, 0)

## ---- Top quartiles -----------------------------------------------------------



** ----  Calculate top quartiles -------------------------------------------------------
xtile ksp_detach_quart = ksp_detach, nq(4)
xtile ksp_ang_quart = ksp_ang, nq(4)
xtile ksp_imp_quart = ksp_imp, nq(4)
xtile ksp_monav_quart = ksp_monav, nq(4)
xtile ksp_sup_quart = ksp_sup, nq(4)

** ---- Calculate variable indicating whether scored in top quartile for each domain 
gen mat_ksp_sup_topQ = 0
replace mat_ksp_sup_topQ =1 if ksp_sup_quart==4

gen mat_ksp_imp_topQ=0
replace mat_ksp_imp_topQ = 1 if ksp_imp_quart==4

gen mat_ksp_detach_topQ =0
replace mat_ksp_detach_topQ = 1 if ksp_detach_quart==4

gen mat_ksp_ang_topQ=0
replace mat_ksp_ang_topQ =1 if ksp_ang_quart==4

gen mat_ksp_monav_topQ=0
replace mat_ksp_monav_topQ=1 if ksp_monav_quart==4

** ---- Final summary variables -------------------------------------------------------------

** 4 category variable indicating number of domains scored in top quartile
egen mat_pers_symp = rowtotal (mat_ksp_sup_topQ mat_ksp_imp_topQ mat_ksp_detach_topQ mat_ksp_ang_topQ mat_ksp_monav_topQ)
replace mat_pers_symp = 3 if mat_pers_symp ==4 | mat_pers_symp ==5 
replace mat_pers_symp = . if ksp_sup ==.
label variable mat_pers_symp "Maternal: Number of personality domains scored in top quartile"

** Binary version (high on 3 domains vs all others)
gen mat_pers_bin = mat_pers_symp
recode mat_pers_bin (0=0) (1=0) (2=0) (3=1)
label variable mat_pers_bin "Maternal: Top quartile in >=3 personality domains"
label define mat_pers_bin 0 "Maternal: low maladpative personality" 1 "Maternal: high maladaptive personality" 

********************************************************************************
* 2. Paternal Maladaptive Personality  
********************************************************************************

** ---- Recode where required and set values <0 to missing ---------------------

*Anger
replace pm5014 =. if pm5014 <0 
recode pm5014 1=4 2=3 3=2 4=1
replace pm5015 =. if pm5015 <0 
recode pm5015 1=4 2=3 3=2 4=1 
replace pm5018 =. if pm5018 <0
replace pm5034 =. if pm5034 <0
replace pm5042 =. if pm5042 <0
replace pm5086 =. if pm5086 <0
replace pm5094 =. if pm5094 <0
replace pm5122 =. if pm5122 <0
replace pm5125 =. if pm5125 <0
replace pm5128 =. if pm5128 <0

*Detachment
replace pm5024 =. if pm5024 <0 
recode pm5024 1=4 2=3 3=2 4=1
replace pm5037 =. if pm5037 <0
replace pm5051 =. if pm5051 <0
replace pm5077 =. if pm5077 <0
replace pm5081 =. if pm5081 <0
replace pm5091 =. if pm5091 <0
replace pm5104 =. if pm5104 <0
replace pm5117 =. if pm5117 <0
replace pm5118 =. if pm5118 <0

*Impulsivity
replace pm5126 =. if pm5126 <0
replace pm5100 =. if pm5100 <0
replace pm5080 =. if pm5080 <0
replace pm5079 =. if pm5079 <0
replace pm5047 =. if pm5047 <0 
replace pm5029 =. if pm5029 <0
replace pm5019 =. if pm5019 <0
replace pm5007 =. if pm5007 <0
recode pm5019 1=4 2=3 3=2 4=1 

*Monotony avoidance
replace pm5001 =. if pm5001 <0
replace pm5009 =. if pm5009 <0
replace pm5021 =. if pm5021 <0 
recode pm5021 1=4 2=3 3=2 4=1
replace pm5027 =. if pm5027 <0
replace pm5043 =. if pm5043 <0
replace pm5053 =. if pm5053 <0
replace pm5072 =. if pm5072 <0
replace pm5076 =. if pm5076 <0 
replace pm5101 =. if pm5101 <0
replace pm5108 =. if pm5108 <0
replace pm5129 =. if pm5129 <0

*Suspicion
replace pm5011 =. if pm5011 <0 
recode pm5011 1=4 2=3 3=2 4=1
replace pm5023 =. if pm5023 <0
replace pm5044 =. if pm5044 <0
replace pm5054 =. if pm5054 <0
replace pm5070 =. if pm5070 <0
replace pm5084 =. if pm5084 <0
replace pm5102 =. if pm5102 <0
replace pm5106 =. if pm5106 <0 
recode pm5106 1=4 2=3 3=2 4=1
replace pm5113 =. if pm5113 <0


** ---- Create summary scores for each domain --------------------------------------------
egen pat_ksp_ang = rowtotal (pm5014 pm5015 pm5018 pm5034 pm5042 pm5086 pm5094 pm5122 pm5125 pm5128)
replace pat_ksp_ang =. if pm5014 ==.

egen pat_ksp_detach = rowtotal (pm5024 pm5037 pm5051 pm5077 pm5081 pm5091 pm5104 pm5117 pm5118)
replace pat_ksp_detach =. if pm5024 ==.

egen pat_ksp_imp = rowtotal (pm5126 pm5100 pm5080 pm5079 pm5047 pm5029 pm5019 pm5007)
replace pat_ksp_imp = . if pm5126 ==. 

egen pat_ksp_monav = rowtotal (pm5001 pm5009 pm5021 pm5027 pm5043 pm5053 pm5072 pm5076 pm5101 pm5108 pm5129)
replace pat_ksp_monav =. if pm5001 ==. 

egen pat_ksp_sup = rowtotal (pm5011 pm5023 pm5044 pm5054 pm5070 pm5084 pm5102 pm5106 pm5113)
replace pat_ksp_sup =. if pm5011 ==. 


** ---- Calculate variable indicating top quartile scoring per domain
xtile pat_ang_quart = pat_ksp_ang, nq(4)
xtile pat_detach_quart = pat_ksp_detach, nq(4)
xtile pat_imp_quart = pat_ksp_imp, nq(4)
xtile pat_monav_quart = pat_ksp_monav, nq(4)
xtile pat_sup_quart = pat_ksp_sup, nq(4)

** ---- Calculate variable indicating whether scored in top quartile for each domain
gen pat_ksp_ang_topQ=0
replace pat_ksp_ang_topQ =1 if pat_ang_quart==4

gen pat_ksp_detach_topQ =0
replace pat_ksp_detach_topQ = 1 if pat_detach_quart==4

gen pat_ksp_imp_topQ=0
replace pat_ksp_imp_topQ = 1 if pat_imp_quart==4

gen pat_ksp_monav_topQ=0
replace pat_ksp_monav_topQ=1 if pat_monav_quart==4

gen pat_ksp_sup_topQ = 0
replace pat_ksp_sup_topQ =1 if pat_sup_quart==4


** ---- Final summary variables -------------------------------------------------------------

** 4 category variable indicating number of domains scored in top quartile
egen pat_pers_symp = rowtotal (pat_ksp_sup_topQ pat_ksp_imp_topQ pat_ksp_detach_topQ pat_ksp_ang_topQ pat_ksp_monav_topQ)
replace pat_pers_symp = 3 if pat_pers_symp ==4 | pat_pers_symp ==5 
replace pat_pers_symp = . if pat_ksp_sup_topQ==.
label variable pat_pers_symp "Paternal: Number of personality domains scored in top quartile"

*** Binary version (high on 3 domains vs all others)
gen pat_pers_bin = pat_pers_symp
recode pat_pers_bin (0=0) (1=0) (2=0) (3=1)
label variable pat_pers_bin "Paternal: Top quartile in >=3 personality domains"
label define pat_pers_bin 0 "Paternal: low maladpative personality" 1 "Paternal: high maladaptive personality" 

********************************************************************************
* 3. Drop temporary variables  
********************************************************************************

drop ksp_ang ksp_detach ksp_imp ksp_monav ksp_sup ksp_detach_quart ksp_ang_quart ksp_imp_quart ksp_monav_quart ksp_sup_quart ///
mat_ksp_sup_topQ mat_ksp_imp_topQ mat_ksp_detach_topQ mat_ksp_ang_topQ mat_ksp_monav_topQ pat_ksp_ang pat_ksp_detach pat_ksp_imp ///
pat_ksp_monav pat_ksp_sup


