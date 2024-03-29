################################################################################
## Project: 
## Script purpose: 
## Date: 
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

library(kable)
library(rmarkdown)

## Notes:

# See useful-code-r/mystyles.sty for syntax on changing the headers. Note that for
# some reason I need to have all the latex packages loaded in that document as well
# as the rmarkdown script or it won't compile.

################################################################################
# 1. Set-up  
################################################################################
library(showtext)
library(extrafont)

## ---- Point r to pandoc ------------------------------------------------------
Sys.setenv(RSTUDIO_PANDOC="C:/Users/tc18889/AppData/Local/Pandoc")

## ---- Add any extra fonts I want ---------------------------------------------
windowsFonts("Arnhem-Blond" = windowsFont("Arnhem-Blond"))
windowsFonts("Arnhem-BlondItalic" = windowsFont("Arnhem-BlondItalic"))
windowsFonts("Arnhem-Bold" = windowsFont("Arnhem-Bold"))
windowsFonts("Arnhem-Bolditalic" = windowsFont("Arnhem-Bolditalic"))

AkzidenzGroteskPro-Regular

windowsFonts("AkzidGroProLig" = windowsFont("AkzidGroProLig"))
windowsFonts("AkzidGroProReg" = windowsFont("AkzidGroProReg"))
windowsFonts("AkzidGroProMed" = windowsFont("AkzidGroProMed"))

font_add("Arnhem-Blond", "Arnhem-Blond.otf") # Adds fonts to showtext library
font_add("AkzidGroProLig", "AkzidGroProLig.otf")
font_add("AkzidGroProReg", "AkzidGroProReg.otf")
font_add("AkzidGroProMed", "AkzidGroProMed.otf")

showtext_auto() # Globally sets to use showtext in graphs

## ---- Set up .pdf rendering --------------------------------------------------
tinytex::install_tinytex()


################################################################################
# 2. Render the .rmd file  
################################################################################

## This is the report for Laura 13.02.19

rmarkdown::render("c:/repos/school-enjoyment-mh/code/semh-report-sem-pdf.rmd", 
	output_file="c:/repos/school-enjoyment-mh/reports/school_enjoyment_mh_analysis.pdf")
system2("open","c:/repos/school-enjoyment-mh/reports/school_enjoyment_mh_analysis.pdf")

## This is the additional CFA on age 12 items
rmarkdown::render("c:/repos/school-enjoyment-mh/code/semh-report-cfa12.rmd", 
	output_file="c:/repos/school-enjoyment-mh/reports/semh-age_12_cfa.pdf")
system2("open","c:/repos/school-enjoyment-mh/reports/semh-age_12_cfa.pdf")

## And here looking at the effect of BMI on school experience
rmarkdown::render("c:/repos/school-enjoyment-mh/code/semh-report-bmi.rmd", 
	output_file="c:/repos/school-enjoyment-mh/reports/semh-bmi.pdf")
system2("open","c:/repos/school-enjoyment-mh/reports/semh-bmi.pdf")


################################################################################
# LifeCycle data planning  
################################################################################

rmarkdown::render("c:/repos/lc-trajectories-inequality/code/lc-traj-ineq-plan.rmd",
	output_file="c:/repos/lc-trajectories-inequality/reports/plan_19.02.19.pdf")

system2("open","c:/repos/lc-trajectories-inequality/reports/plan_19.02.19.pdf")

################################################################################
# GOSH asc-sex  
################################################################################
 rmarkdown::render("C:/repos/gosh-asc-sex/code/gosh-asc-sex-missing.rmd",
	output_file="C:/repos/gosh-asc-sex/reports/missing.pdf")
system2("open","C:/repos/gosh-asc-sex/reports/missing.pdf")

################################################################################
# Constanza report  
################################################################################
rmarkdown::render("C:/repos/life-cycle/wp3/code/wp3-constanza_04.03.19.rmd",
	output_file="C:/repos/life-cycle/wp3/reports/wp3-constanza.pdf")
system2("open","C:/repos/life-cycle/wp3/reports/wp3-constanza.pdf")


################################################################################
# TPF report  
################################################################################
rmarkdown::render("C:/repos/teen-parenting/code/tpf-report-efa.rmd",
	output_file="C:/repos/teen-parenting/reports/tpf-report-efa_06.03.19.pdf")
system2("open","C:/repos/teen-parenting/reports/tpf-report-efa_06.03.19.pdf")


################################################################################
# Alspac errors  
################################################################################
rmarkdown::render("tim_alspac_r_13.03.19.Rmd",
	output_file="tim_alspac_r_13.03.19.pdf")
system2("open","tim_alspac_r_13.03.19.pdf")


################################################################################
# Test with Kathryn  
################################################################################
rmarkdown::render("c:/repos/useful-code-r/code/reports/report-design.rmd",
	output_file="c:/repos/useful-code-r/code/reports/report-design.pdf")

system2("open","c:/repos/useful-code-r/code/reports/report-design.pdf")


################################################################################
# Latest SEMH SEM  
################################################################################
rmarkdown::render("c:/repos/school-enjoyment-mh/code/semh-analysis-xl-report.Rmd", 
	output_file="c:/repos/school-enjoyment-mh/reports/semh-analysis-xl-report.pdf")

system2("open","c:/repos/school-enjoyment-mh/reports/semh-analysis-xl-report.pdf")


################################################################################
# 3. Testing
################################################################################

rmarkdown::render("C:/repos/stats-learning/code/practice-rmd 13.02.19.rmd", 
	output_file="C:/repos/stats-learning/reports/test.pdf")
system2("open","C:/repos/stats-learning/reports/test.pdf")


rmarkdown::render("C:/repos/stats-learning/reports/test_29_03_19.rmd", 
	output_file="C:/repos/stats-learning/reports/test_29_03_19.pdf")
system2("open","C:/repos/stats-learning/reports/test_29_03_19.pdf")

################################################################################
# Constanza 2nd April 2019  
################################################################################
rmarkdown::render("c:/repos/life-cycle/wp3/code/alspac_missing_02_04_19.Rmd",
	output_file = "c:/repos/life-cycle/wp3/reports/alspac_missing_02_04_19.pdf")

system2("open","c:/repos/life-cycle/wp3/reports/alspac_missing_02_04_19.pdf")

