################################################################################
## Project: useful-code-r
## Script purpose: Create default theme to use in ggplot plots
## Date: 4th February 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

library(ggplot2)

################################################################################
# 1. Add the fonts we need  
################################################################################
font_add("Arnhem-Blond", "Arnhem-Blond.otf") # Adds fonts to showtext library
font_add("AkzidGroProLig", "AkzidGroProLig.otf")
font_add("AkzidGroProReg", "AkzidGroProReg.otf")
font_add("AkzidGroProMed", "AkzidGroProMed.otf")

################################################################################
# 2. Create theme  
################################################################################
theme_khl <- theme(plot.background = element_rect(fill =scales::alpha("#CCCCCC", 0.3)),  #Background outside of plot
               panel.background = element_rect(fill="white"),  #Background for plot
               panel.grid.major=element_line(colour="grey"), #Major and minor gridlines
               panel.grid.minor=element_line(colour="white"), 
               plot.title = element_text(hjust = 0, vjust=0, size=10, face="bold"), #Plot title, thought don't tend to use
               text=element_text(size=10), #General text 
               axis.title.y = element_text(family="AkzidGroProLig", size=10, face="bold", margin = margin(t = 0, r = 10, b = 0, l = 0)), #Axis labels
               axis.title.x = element_text(family="AkzidGroProLig", size=10, face="bold", margin = margin(t = 10, r = 0, b = 0, l = 0)),
               axis.text.x = element_text(family="AkzidGroProReg", size=7, margin = margin(t = 4, r=0, b=0, l=0), colour="black"), #Axis text
               axis.text.y = element_text(family="AkzidGroProReg", size=7, margin = margin(t = 0, r=4, b=0, l=0), colour="black"),
               axis.ticks.length=unit(0.3, "cm"),
               axis.ticks = element_line(colour = "grey"),
               strip.text.x = element_text(family="AkzidGroProMed", size=8, face="bold"),
               legend.background= element_rect(fill=scales::alpha("#CCCCCC", 0.3)), #Legend background colour
               legend.title=element_text(size=8, face="bold"), #Legend title
               legend.text=element_text(size=8), #Legend text
               legend.position="top", #Legend position
               legend.direction="vertical", #Legend stacking
               legend.justification = "left", #Left justify legend
               legend.key.width = unit(3, "line"), #Make amount of line displayed in legend longer
               legend.margin=margin(t=-1, r=0, b=0.2, l=0, unit="cm"), #Margin around legend
               plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm")) #Margin around (everything) in the plot

################################################################################
# 3. Create palette  
################################################################################
palette_khl <- c("#197d78", "#d79632", "#325573", "#d74632", "#d77896", 
                 "#827d78", "#4by6be", "#le8c32")

################################################################################
# 4. Create objects holding axis configuration  
################################################################################
x_axis <- scale_x_continuous(expand = c(0, 0)) # Removes space before 0
y_axis <- scale_y_continuous(expand = c(0, 0))