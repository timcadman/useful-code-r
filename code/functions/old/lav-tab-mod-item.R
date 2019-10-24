lavTableModItem <- function(object){

tab_mod <- modindices(object, standardized=TRUE) %>% 
filter(op == "~~") %>%
  select(lhs, rhs, mi) 

colnames(tab_mod) <- c("Item 1", "Item 2", "Modification indice")

return(tab_mod)

}