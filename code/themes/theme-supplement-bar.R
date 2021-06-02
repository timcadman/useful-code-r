################################################################################
## Project: useful-code-r
## Script purpose: Supplementary theme for bar charts
## Date: 2nd June 2021
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

library(ggplot2)

theme_bar <- theme(
  legend.position = "none",
  panel.grid.major.y=element_line(colour="grey"), 
  panel.grid.major.x=element_line(colour="white"),
  axis.title.x=element_blank(),
  axis.ticks.x=element_blank()
)