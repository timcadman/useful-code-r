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

## ---- Point r to pandoc ------------------------------------------------------
Sys.setenv(RSTUDIO_PANDOC="C:/Users/tc18889/AppData/Local/Pandoc")

## ---- Add any extra fonts I want ---------------------------------------------
windowsFonts("Arnhem-Blond" = windowsFont("Arnhem-Blond"))
windowsFonts("Arnhem-BlondItalic" = windowsFont("Arnhem-BlondItalic"))
windowsFonts("Arnhem-Bold" = windowsFont("Arnhem-Bold"))
windowsFonts("Arnhem-Bolditalic" = windowsFont("Arnhem-Bolditalic"))

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
# 3. Testing
################################################################################

rmarkdown::render("C:/repos/stats-learning/code/practice-rmd 13.02.19.rmd", 
	output_file="C:/repos/stats-learning/reports/test.pdf")
system2("open","C:/repos/stats-learning/reports/test.pdf")



 rmarkdown::render("C:/repos/gosh-asc-sex/code/gosh-asc-sex-missing.rmd", 
	output_file="C:/repos/gosh-asc-sex/reports/missing.pdf")
system2("open","C:/repos/gosh-asc-sex/reports/missing.pdf")
