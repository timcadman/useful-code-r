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


################################################################################
# 3. Import and register fonts  
################################################################################

library(extrafont)
font_import()
loadfonts(device="win")
