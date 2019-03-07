################################################################################
## Project: useful-code-r
## Script purpose: Create default theme to use in ggplot plots
## Date: 4th February 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

################################################################################
# 1. Theme modified to Psychological Medicine guidelines
################################################################################

# Key elements are font=Arial and fontsize=8. At the moment I've left the font sizes
# different as they look better: when we get closer to submission I can work this out
# exactly.

theme_pm <- theme(plot.background = element_rect(fill =scales::alpha("#CCCCCC", 0.3)),  #Background outside of plot
               panel.background = element_rect(fill="white"),  #Background for plot
               panel.grid.major=element_line(colour="grey"), #Major and minor gridlines
               panel.grid.minor=element_line(colour="white"), 
               plot.title = element_text(hjust = 0, vjust=0, size=10, face="bold"), #Plot title, thought don't tend to use
               text=element_text(family="Arial", size=10), #General text 
               axis.title.y = element_text(family="Arial", size=8, face="bold", margin = margin(t = 0, r = 10, b = 0, l = 0)), #Axis labels
               axis.title.x = element_text(family="Arial", size=8, face="bold", margin = margin(t = 10, r = 0, b = 0, l = 0)),
               axis.text.x = element_text(family="Arial", size=6, margin = margin(t = 4, r=0, b=0, l=0), colour="black"), #Axis text
               axis.text.y = element_text(family="Arial", size=6, margin = margin(t = 0, r=4, b=0, l=0), colour="black"),
               strip.text.x = element_text(size=8, face="bold"),
               legend.background= element_rect(fill=scales::alpha("#CCCCCC", 0)), #Legend background colour
               legend.title=element_text(size=8, face="bold"), #Legend title
               legend.text=element_text(size=8), #Legend text
               legend.position="top", #Legend position
               legend.direction="vertical", #Legend stacking
               legend.justification = "left", #Left justify legend
               legend.key.width = unit(3, "line"), #Make amount of line displayed in legend longer
               legend.margin=margin(t=-1, r=0, b=0.2, l=0, unit="cm"), #Margin around legend
               plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm")) #Margin around (everything) in the plot
