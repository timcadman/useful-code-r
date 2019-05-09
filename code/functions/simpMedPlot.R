################################################################################
## Project: useful-code-r
## Script purpose: Create simple mediation plots
## Date: 27th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# This makes a simple mediation plot going latent --> latent --> outcome.
# If it looks like I'll reuse this a lot I will generalise it.
#
# Arguments:
#
# labels: vector of three variable names in the order produced by LavTab Struc
# object: Lavaan fitted object
# filename: file path to save the plot

library(DiagrammeR)

simpMedPlot <- function(labels, object, colour1, colour2, colour3, filename){

source("c:/repos/useful-code-r/code/functions/sigStars.r")
source("c:/repos/useful-code-r/code/functions/lav-tab-struc.r")
source("c:/repos/useful-code-r/code/functions/lavSigCoef.r")

colours <- c(colour1, colour2, colour3)

coefs <- lavSigCoef(object)

coefs <- coefs[c(2, 3, 1)]

nodes <-
  create_node_df(
  	n = 3,
  	label = labels,
  	shape = c("circle", "circle", "square"),
    width = 0.8,
  	fillcolor = colours,
  	color = colours,
  	fontcolor = c("black", "black", "black"), 
  	fontname = c("Akzidenz-Grotesk Pro Regular", "Akzidenz-Grotesk Pro Regular", 
                 "Akzidenz-Grotesk Pro Regular"),
    fontsize = 11,
    fontpath = c("c:/windows/fonts/", "c:/windows/fonts/", "c:/windows/fonts/"),
    style = c('filled, setlinewidth(0)', 'filled, setlinewidth(0)', 
              'filled, setlinewidth(0)'))

paths <- 
  create_edge_df(
  	from = c(1, 2, 1),
  	to = c(2, 3, 3),
  	label = coefs)

test_plot <- create_graph(
	nodes_df = nodes,
	edges_df = paths) %>%
add_global_graph_attrs(
    attr = c("layout", "rankdir"),
    value = c("dot", "LR"),
    attr_type = c("graph", "graph")) 

export_graph(test_plot, file_name = filename, width = 290)

}