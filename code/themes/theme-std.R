################################################################################
## Project: useful-code-r 
## Script purpose: General theme for plotting
## Date: 31.05.21
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################
library(ggplot2)

## ---- Theme ------------------------------------------------------------------
theme_std <- theme(
  plot.background = element_rect(fill =scales::alpha("#CCCCCC", 0.3)),  #Background outside of plot
  panel.background = element_rect(fill="white"),  #Background for plot
  panel.grid.major=element_line(colour="grey"), #Major and minor gridlines
  panel.grid.minor=element_line(colour="white"), 
  panel.spacing = unit(1, "lines"),
  plot.title = element_text(hjust = 0.5, vjust=0, size=12, face="bold"), #Plot title, thought don't tend to use
  text=element_text(size=9), #General text 
  axis.title.y = element_text(size=14, margin = margin(t = 0, r = 10, b = 0, l = 0)), #Axis labels
  axis.title.x = element_text(size=14, margin = margin(t = 10, r = 0, b = 0, l = 0)),
  axis.text.x = element_text(size=11, margin = margin(t = 4, r=0, b=0, l=0), colour="black"), #Axis text
  axis.text.y = element_text(size=11, margin = margin(t = 0, r=4, b=0, l=0), colour="black"),
  axis.ticks.length=unit(0.3, "cm"),
  axis.ticks = element_line(colour = "grey"),
  strip.text.x = element_text(size = 8, face = "bold"),
  strip.background = element_blank(),
  legend.background= element_rect(fill=scales::alpha("#CCCCCC", 0.03)), #Legend background colour
  legend.title=element_text(size=8, face="bold"), #Legend title
  legend.text=element_text(size=8), #Legend text
  legend.position="right", #Legend position
  legend.direction="vertical", #Legend stacking
  legend.justification = "left", #Left justify legend
  legend.key.width = unit(3, "line"), #Make amount of line displayed in legend longer
  legend.margin=margin(t=0.2, r=0, b=0.2, l=0, unit="cm"), #Margin around legend
  plot.margin = unit(c(0.5, 0.5, 0.2, 0.5),"cm"),
  panel.grid.minor.y=element_blank(),
  panel.grid.major.y=element_blank())


palette_std <- c("#264653", "#2a9d8f", "#E9C46A", "#F4A261", "#E76F51", "#000000")