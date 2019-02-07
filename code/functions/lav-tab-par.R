lavTablePar <- function(object, vartable){

partab <- parameterEstimates(object, standardized=TRUE) %>% 
  filter(op == "=~") %>% 
  select(Indicator=rhs, Beta=std.all)

varlabs <- vartable$lab[match(as.character(vartable$name), as.character(partab$Indicator))]

out <- data.frame(partab$Indicator, varlabs, partab$Beta)
colnames(out) <- c("Variable name", "Variable label", "Beta")

return(out)}