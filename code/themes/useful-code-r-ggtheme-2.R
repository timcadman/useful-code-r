################################################################################
## Project: useful-code-r
## Script purpose: Create default theme to use in ggplot plots
## Date: 4th February 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

################################################################################
# 1. Revised theme used in the School Enjoyment project plots  
################################################################################

# I think this is probably just an improvement on the original theme, but I'll keep it for now
# as there may be previously plots which it is better for.

theme_2 <- theme(plot.background = element_rect(fill =scales::alpha("#CCCCCC", 0.3)),  #Background outside of plot
               panel.background = element_rect(fill="white"),  #Background for plot
               panel.grid.major=element_line(colour="grey"), #Major and minor gridlines
               panel.grid.minor=element_line(colour="white"), 
               plot.title = element_text(hjust = 0, vjust=0, size=12, face="bold"), #Plot title, thought don't tend to use
               text=element_text(family="Calibri", size=10), #General text 
               axis.title.y = element_text(family="Calibri", size=12, face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0)), #Axis labels
               axis.title.x = element_text(family="Calibri", size=12, face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
               axis.text.x = element_text(family="Calibri", size=10, margin = margin(t = 8, r=0, b=0, l=0), colour="black"), #Axis text
               axis.text.y = element_text(family="Calibri", size=10, margin = margin(t = 0, r=8, b=0, l=0), colour="black"),
               legend.background= element_rect(fill=scales::alpha("#CCCCCC", 0)), #Legend background colour
               legend.title=element_text(size=10, face="bold"), #Legend title
               legend.text=element_text(size=10), #Legend text
               legend.position="top", #Legend position
               legend.box="horizontal", #Legend stacking
               legend.margin=margin(t=-0.5, r=0, b=0.2, l=0, unit="cm"), #Margin around legend
               plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm")) #Margin around plot