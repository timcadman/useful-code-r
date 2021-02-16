################################################################################
## Project: useful-code-r 
## Script purpose: Theme for forest plot
## Date: 3rd February 2021
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

library(ggplot2)

forest_theme <- theme(
  plot.background = element_rect(fill =scales::alpha("#CCCCCC", 0.3)),  #Background outside of plot
  panel.background = element_rect(fill="white"),  #Background for plot
  panel.grid.major=element_line(colour="grey"), #Major and minor gridlines
  panel.grid.minor=element_line(colour="white"), 
  panel.spacing = unit(1, "lines"),
  plot.title = element_text(hjust = 0, vjust=0, size=11, face="bold"), #Plot title, thought don't tend to use
  text=element_text(size=10), #General text 
  axis.title.y = element_text(family="ArialMT", size=11, margin = margin(t = 0, r = 10, b = 0, l = 0)), #Axis labels
  axis.title.x = element_text(family="ArialMT", size=11, margin = margin(t = 10, r = 0, b = 0, l = 0)),
  axis.text.x = element_text(family="ArialMT", size=8, margin = margin(t = 4, r=0, b=0, l=0), colour="black"), #Axis text
  axis.text.y = element_text(family="ArialMT", size=8, margin = margin(t = 0, r=4, b=0, l=0), colour="black"),
  axis.ticks.length=unit(0.3, "cm"),
  axis.ticks = element_line(colour = "grey"),
  strip.text.x = element_text(family="ArialMT", size=11),
  strip.text.y = element_text(family="ArialMT", size=8, face = "bold"),
  strip.background = element_blank(),
  plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm"),
  legend.position = "none") 