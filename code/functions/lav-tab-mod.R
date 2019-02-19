lavTableModa <- function(object){

tab_mod <- modindices(object, standardized=TRUE) %>% 
filter(op == "=~") %>%
  select(lhs, rhs, mi) 

colnames(tab_mod) <- c("Factor", "Indicator", "Modification indice")

return(tab_mod)

}