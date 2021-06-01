################################################################################
## Project: useful-code-r
## Script purpose: Just to keep a track of all the packages I've installed - sometimes this has been lost when I update R.
## Date: 4th February 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Remember to set the library paths as per this thread:

# https://stackoverflow.com/questions/15170399/change-r-default-library-path-using-libpaths-in-rprofile-site-fails-to-work

################################################################################
# 2. List of packages I ever use  
################################################################################

install.packages("extrafont")
install.packages("ggplot2")
install.packages("plyr")
install.packages("Cairo")
install.packages("readstata13")
install.packages("dplyr")
install.packages("FactoMineR")
install.packages("mirt")
install.packages("ltm")
install.packages("gridExtra")
install.packages("latticeExtra")
install.packages("psych")
install.packages("rlang")
install.packages("devtools")
install.packages("Rtools")
library(devtools)
install_github("explodecomputer/alspac")
install.packages("lavaan", repos = "http://www.da.ugent.be", type = "source")
devtools::install_github("simsem/semTools/semTools")
install.packages("semPlot")
install.packages("knitr")
install.packages("rmarkdown")
install.packages("installr")
install.packages("kableExtra")
install.packages("tinytex")
install.packages("extrafont")
install.packages("tableone")
install.packages("VIM")
install.packages("visdat")
install.packages("magrittr")
install.packages("qwraps2")
install.packages("effects")
install.packages("R2MLwiN")
install.packages("bookdown")
install.packages("languageserver")
install.packages("cairoDevice")
install.packages("installr")
install.packages("polycor")
install.packages("GPArotation")
install.packages("purrr")
install.packages("mice")
install.packages("captioner")
install.packages("qqtest")
install.packages("showtext")
install.packages("tidygraph")
install.packages("tidyverse")
install.packages("ggraph")
install.packages("QuantPsyc")
install.packages("rms")
install.packages("broom")
install.packages("rlang")
install.packages("skimr")
install.packages("mdscore")
install.packages("stringr")
install.packages("statar")
install.packages("summarytools")
install.packages("labelled")
install.packages("lspline")
install.packages("lifecycleProject", 
	repos='https://registry.molgenis.org/repository/R/', 
	dependencies = TRUE)
install.packages('opal', repos='http://cran.obiba.org', type='source')
install.packages('dsBaseClient', repos='http://cran.obiba.org', type='source')
install_github("datashield/dsBetaTestClient", ref = "master", force = TRUE)
install.packages("metafor")
install.packages('datashieldclient', repos=c(getOption('repos'), 'http://cran.datashield.org'), dependencies=TRUE)
install.packages("miceadds")
install.packages("zscorer")
install.packages("gsubfn")
install.packages("PHEindicatormethods")
install.packages("sjmisc")
devtools::install_github("thlytras/rspiro")
install.packages("igraph")
install.packages("ggraph")


################################################################################
# 3. Import and register fonts  
################################################################################

library(extrafont)
font_import()
loadfonts(device="win")
