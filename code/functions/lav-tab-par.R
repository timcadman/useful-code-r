lavTablePar <- function(object, vartable){

partab <- parameterEstimates(object, standardized=TRUE) %>% 
  filter(op == "=~") %>% 
  dplyr::select(Indicator=rhs, Beta=std.all)

varlabs <- vartable$lab[match(as.character(partab$Indicator), as.character(vartable$name))]

out <- data.frame(partab$Indicator, varlabs, partab$Beta)
colnames(out) <- c("", "", "Beta")

return(out)}