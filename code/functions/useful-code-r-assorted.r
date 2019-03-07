########## Useful code ##########

# Produces frequency tables for selected variables
select(data.wp1, n4100:n4112) %>%
  sapply(table)


# Makes 2x2 contingency tables for selected items
tablevars <- select(data.wp314, kq820a, kq820b, kq820c, kq820d, kq820e, kq820f, kq820g,
                    kq820a_cont, kq820b_cont, kq820c_cont, kq820d_cont, kq820e_cont, 
                    kq820f_cont, kq820g_cont)
                    
  

out <- list()
for (i in colnames(tablevars)){
  out[[i]] <- table(tablevars[,i], tablevars[,paste0(i, "_cont")])
}

out

# Increase length of list displayed to size of dataframe
str(df, list.len=ncol(df))

# Find position of variable name
which(names(x)=="bar")