irtEmpirical <- function(irtobject, graphname){
  
  library(gridExtra)
  library(ggplot2)
  
  # Plots residual graph using the built-in function (which I have more confidence in than the one I wrote)
  # 
  # # Args:
  #  irtobject: a MIRT object
  #  graphname: name for output file of graph (ending .pdf)
  #  Returns: a pdf file with the graphs on, containing 3 rows of graph per page
  
  
  #Calculate number of items and number of pages (3 items/page)
  nitems <- as.numeric(irtobject@Data$nitems)

  #Retrieve item names
  itemnames <- colnames(irtobject@Data$data)
  
  #Make list of empirical plots
  
  graph.list.emp <- list()
  
  for (i in 1:nitems)
    
    local({
      
      graph.emp <- itemfit(irtobject, empirical.plot = i)
      graph.emp$main <- deparse(colnames(irtobject@Data$data)[i])
      print(graph.emp)
      graph.list.emp[[i]] <<- graph.emp
      
    })
 
  #Save as multipage pdf
  graph.out.emp <- marrangeGrob(graph.list.emp, nrow=1, ncol=1)
  ggsave(graphname, graph.out.emp)
  
}