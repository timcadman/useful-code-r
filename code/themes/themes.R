################################################################################
## Project: useful-code-r 
## Script purpose: General theme for plotting with palette
## Date: 31.05.21
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

library(ggplot2)


## ---- Palette ----------------------------------------------------------------
palette_std <- c("#264653", "#2a9d8f", "#E9C46A", "#F4A261", "#E76F51", 
  "#000000")

palette_ext <- c("#001219","#005f73","#0a9396","#94d2bd","#e9d8a6","#ee9b00",
                 "#ca6702","#bb3e03","#ae2012","#9b2226")


## ---- Standard theme ---------------------------------------------------------
theme_std <- theme(
  plot.background = element_rect(fill =scales::alpha("#CCCCCC", 0.3)),  
  panel.background = element_rect(fill="white"), 
  panel.grid.major = element_line(colour="grey"), 
  panel.grid.minor = element_line(colour="white"), 
  panel.spacing = unit(1, "lines"),
  plot.title = element_text(
    family = "avenir-book", 
    hjust = 0.5, 
    vjust = 0, size = 12, face = "bold"), 
  text = element_text(family = "avenir-book", size = 9), 
  axis.title.y = element_text(
    family = "avenir-book", 
    size = 14, margin = margin(t = 0, r = 10, b = 0, l = 0)), 
  axis.title.x = element_text(
    family = "avenir-book", 
    size = 14, 
    margin = margin(t = 10, r = 0, b = 0, l = 0)),
  axis.text.x = element_text(
    family = "avenir-book", 
    size = 11, 
    margin = margin(t = 4, r = 0, b = 0, l = 0), 
    colour = "black"), 
  axis.text.y = element_text(
    family = "avenir-book", 
    size = 11, 
    margin = margin(t = 0, r = 4, b = 0, l = 0), colour = "black"),
  axis.ticks.length=unit(0.3, "cm"),
  axis.ticks = element_line(colour = "grey"),
  strip.text.x = element_text(family = "avenir-book", size = 8, face = "bold"),
  strip.background = element_blank(),
  legend.background = element_rect(fill = scales::alpha("#CCCCCC", 0.03)), 
  legend.title = element_text(family = "avenir-book", size = 8, face = "bold"), 
  legend.text = element_text(family = "avenir-book", size = 8), 
  legend.position = "right", 
  legend.direction = "vertical", 
  legend.justification = "left", 
  legend.key.width = unit(3, "line"), 
  legend.margin = margin(t = 0.2, r = 0, b = 0.2, l = 0, unit = "cm"), 
  plot.margin = unit(c(0.5, 0.5, 0.2, 0.5),"cm"),
  panel.grid.minor.y = element_blank(),
  panel.grid.major.y = element_blank())


## ---- Half violin plot -------------------------------------------------------------------
theme_hv <- theme(
  legend.position = "none",
  panel.grid.major.y = element_line(colour = "grey"), 
  panel.grid.major.x = element_line(colour = "white"),
  axis.ticks.x =element_blank(), 
  axis.text.x = element_text(
    family = "avenir-book", 
    size = 10, 
    margin = margin(t = 4, r = 0, b = 0, l = 0), 
    colour="black"),
  axis.text.y = element_text(
    family = "avenir-book", 
    size=10, 
    margin = margin(t = 0, r = 4, b = 0, l = 0), 
    colour = "black"),
  axis.title.y = element_text(
    family = "avenir-book", 
    size = 12, 
    margin = margin(t = 0, r = 10, b = 0, l = 0)), 
  axis.title.x = element_text(
    family = "avenir-book", 
    size = 12, 
    margin = margin(t = 10, r = 0, b = 0, l = 0))
)


## ---- Correlation/heat map -------------------------------------------------------------------
theme_cor <- theme(
  plot.title = element_text(
    family = "avenir-book", 
    hjust = 0.5, 
    vjust = 0, 
    size = 12, 
    face = "bold"), 
  text = element_text(family = "avenir-book", size=9), 
  axis.title.y = element_text(
    family = "avenir-book", 
    size = 14, 
    margin = margin(t = 0, r = 10, b = 0, l = 0)), 
  axis.title.x = element_text(
    family = "avenir-book", 
    size = 14, 
    margin = margin(t = 10, r = 0, b = 0, l = 0)),
  axis.text.x = element_text(
    family = "avenir-book", 
    size = 11, 
    margin = margin(t = 4, r = 0, b = 0, l = 0), colour="black"),
  axis.text.y = element_text(
    family = "avenir-book", 
    size = 11, 
    margin = margin(t = 0, r = 4, b = 0, l = 0), colour="black"),
  strip.text.x = element_text(family = "avenir-book", size = 8, face = "bold"),
  legend.background = element_rect(fill=scales::alpha("#CCCCCC", 0.03)), 
  legend.title = element_text(family = "avenir-book", size=8, face="bold"), 
  legend.text = element_text(family = "avenir-book", size=8), 
  legend.position = "right", 
  legend.direction = "vertical", 
  legend.justification = "left", 
  legend.key.width = unit(3, "line"), 
  legend.margin = margin(t = 0.2, r = 0, b = 0.2, l = 0, unit = "cm")) 


## ---- Forest plot ------------------------------------------------------------
theme_forest <- theme(
  legend.position = "none",
  panel.grid.major.x = element_blank(), 
  axis.title.y = element_blank()) 


## ---- Stacked bar chart ------------------------------------------------------
theme_bar_stack <- theme(
  legend.position = "top",
  legend.justification =  "left",
  legend.title = element_blank(),
  panel.grid.major.y = element_line(colour = "grey"), 
  panel.grid.major.x = element_line(colour = "white"),
  axis.ticks.x =element_blank(), 
  axis.text.x = element_text(
    angle = 90, 
    vjust = 0.5, 
    hjust = 1),
  axis.title.x = element_blank()
)

## ---- Modification for smaller font in word ----------------------------------
theme_word <- theme(
  plot.title = element_text(
    family = "avenir-book", 
    hjust = 0.5, 
    vjust = 0, size = 9, face = "bold"), 
  text = element_text(family = "avenir-book", size = 9), 
  axis.title.y = element_text(
    family = "avenir-book", 
    size = 9, margin = margin(t = 0, r = 10, b = 0, l = 0)), 
  axis.title.x = element_text(
    family = "avenir-book", 
    size = 9, 
    margin = margin(t = 10, r = 0, b = 0, l = 0)),
  axis.text.x = element_text(
    family = "avenir-book", 
    size = 7, 
    margin = margin(t = 4, r = 0, b = 0, l = 0), 
    colour = "black"), 
  axis.text.y = element_text(
    family = "avenir-book", 
    size = 7, 
    margin = margin(t = 0, r = 4, b = 0, l = 0), colour = "black"),
  strip.text.x = element_text(family = "avenir-book", size = 9, face = "bold"),
  legend.title = element_text(family = "avenir-book", size = 9, face = "bold"), 
  legend.text = element_text(family = "avenir-book", size = 7), 
  legend.key.size = unit(0.3, "cm"), 
  legend.key.width = unit(0.5, "cm"),
  legend.margin = margin(t = 0.2, r = 0, b = 0.2, l = 0, unit = "cm"), 
  plot.margin = unit(c(0.5, 0.5, 0.2, 0.5),"cm"), 
  legend.direction = "horizontal")


## ---- Theme forest 2 -------------------------------------------------------------------

theme_f2 <- theme(
  plot.title = element_blank(), 
  text = element_text(family = "avenir-book", size = 7), 
  strip.text.x = element_text(family = "avenir-book", size = 9, face = "bold"),
  axis.line = element_blank(), 
  axis.ticks = element_blank(), 
  axis.ticks.length = unit(0.0001, "mm"),
  axis.ticks.margin = unit(c(0,0,0,0), "lines"), 
  legend.position = "none", 
  panel.background = element_rect(fill = "transparent"), 
  panel.border = element_blank(), 
  panel.grid.major = element_line(colour="white"), 
  panel.grid.minor = element_line(colour="white"), 
  axis.title.x = element_text(
      family = "avenir-book", 
      size = 9, 
      margin = margin(t = 10, r = 0, b = 0, l = 0)),
    axis.text.x = element_text(
      family = "avenir-book", 
      size = 7, 
      margin = margin(t = 4, r = 0, b = 0, l = 0), 
      colour = "black"), 
  axis.title.y = element_text(
      family = "avenir-book", 
      size = 9, 
      margin = margin(t = 10, r = 0, b = 0, l = 0)),
  axis.text.y = element_text(
      family = "avenir-book", 
      size = 7, 
      margin = margin(t = 4, r = 0, b = 0, l = 0), 
      colour = "black"))


## ---- Widths for saving plots -------------------------------------------------------------------
word_full <- 18
word_half <- 8.8


