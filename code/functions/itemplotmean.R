itemplotmean <- function(item, datatable, model){
  
  #Extract theta values
  fscores <- fscores(model, full.scores=TRUE)
  
  #Add these to a dataframe with original responses
  table.temp <- datatable
  table.temp$fscores <- fscores
  
  #Sort dataframe by theta scores
  table.temp.sort <- table.temp[order(fscores),]
  
  #Add deciles to dataframe
  decLocations <- quantile(table.temp.sort$fscores, probs = seq(0.1,0.9,by=0.1))
  table.temp.sort$decile <- findInterval(table.temp.sort$fscores,c(-Inf,decLocations, Inf))
  
  #Calculate mean theta value for each decile
  theta.mean <- aggregate(table.temp.sort$fscores, list(table.temp.sort$decile), mean)
  
  #Extract item information
  extr.item <- extract.item(model, item)
  expected.item(extr.item, theta.mean[, 2], min=1)
  
  observed.item <- aggregate(table.temp.sort[, item], list(table.temp.sort$decile), mean)
  expected.item <- expected.item(extr.item, theta.mean[, 2], min=1)
  
  table.item = matrix(NA, ncol=3, nrow=10)
  table.item[, 1] <- theta.mean[, 2]
  table.item[, 2] <- observed.item[, 2]
  table.item[, 3] <- expected.item
  xrange=range(table.item[, 1])
  yrange=c(0, 9)
  plot.item <- plot(table.item[, 1], table.item[, 2], type="p", xlim=xrange, ylim=yrange, xlab="Theta", ylab="Probability", main="item")
  plot.item <- lines(table.item[, 1], table.item[, 3]) 
  
  return(plot.item)
  
}
