################################################################################
## Project: useful-code-r
## Script purpose: Stand-alone theme for correlation heat plots
## Date: 2nd June 2021
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

library(ggplot2)

theme_cor <- theme(
  plot.background = element_rect(fill =scales::alpha("#CCCCCC", 0.3)),  #Background outside of plot
  plot.title = element_text(family = "avenir-book", hjust = 0.5, vjust=0, size=12, face="bold"), #Plot title, thought don't tend to use
  text=element_text(family = "avenir-book", size=9), #General text 
  axis.title.y = element_text(family = "avenir-book", size=14, margin = margin(t = 0, r = 10, b = 0, l = 0)), #Axis labels
  axis.title.x = element_text(family = "avenir-book", size=14, margin = margin(t = 10, r = 0, b = 0, l = 0)),
  axis.text.x = element_text(family = "avenir-book", size=11, margin = margin(t = 4, r=0, b=0, l=0), colour="black"), #Axis text
  axis.text.y = element_text(family = "avenir-book", size=11, margin = margin(t = 0, r=4, b=0, l=0), colour="black"),
  strip.text.x = element_text(family = "avenir-book", size = 8, face = "bold"),
  legend.background= element_rect(fill=scales::alpha("#CCCCCC", 0.03)), #Legend background colour
  legend.title=element_text(family = "avenir-book", size=8, face="bold"), #Legend title
  legend.text=element_text(family = "avenir-book", size=8), #Legend text
  legend.position="right", #Legend position
  legend.direction="vertical", #Legend stacking
  legend.justification = "left", #Left justify legend
  legend.key.width = unit(3, "line"), #Make amount of line displayed in legend longer
  legend.margin=margin(t=0.2, r=0, b=0.2, l=0, unit="cm")) #Margin around legend
