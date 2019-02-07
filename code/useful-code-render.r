################################################################################
## Project: 
## Script purpose: 
## Date: 
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

library(kable)
library(rmarkdown)

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

################################################################################
# 2. Render the .rmd file  
################################################################################

rmarkdown::render("c:/repos/school-enjoyment-mh/code/semh-report-sem.rmd", 
	output_file="c:/repos/school-enjoyment-mh/reports/test.html")
system2("open","c:/repos/school-enjoyment-mh/reports/test.html")

