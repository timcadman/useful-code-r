################################################################################
## Project: useful-code-r
## Script purpose: Create default theme to use in ggplot plots
## Date: 4th February 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

################################################################################
# 1. Standard theme for plots  
################################################################################

theme <- theme(plot.background = element_rect(fill =scales::alpha("#CCCCCC", 0.3)), 
               panel.background = element_rect(fill="white"), 
               panel.grid.major=element_line(colour="grey"), 
               panel.grid.minor=element_line(colour="white"), 
               plot.title = element_text(hjust = 0, vjust=10, size=13.5, face="bold"), 
               plot.margin=unit(c(0,0.5,0.5,0.5),"cm"), 
               text=element_text(family="Verdana", size=14), 
               axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)),
               axis.title.x = element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)),
               legend.justification = c(0, 0.5), 
               legend.margin=margin(t=0, r=0, b=0, l=0, unit="cm"),
               legend.background= element_rect(fill=scales::alpha("#CCCCCC", 0)),
               legend.title=element_text(size=12),
               legend.position="top",
               legend.direction="vertical",
               axis.text.x = element_text(margin = margin(t = 8, r=0, b=0, l=0), angle=90, hjust=1),
               axis.text.y = element_text(margin = margin(t = 0, r=8, b=0, l=0)))