getNodes <- function(fit){
  # remove . from variable names
  regress <- fit@ParTable$op == "~"
  latent <- fit@ParTable$op == "=~"
  observed_nodes <- c()
  latent_nodes <- c()
  if(any(regress)){
    observed_nodes <- c(observed_nodes, unique(fit@ParTable$rhs[regress]))
    observed_nodes <- c(observed_nodes, unique(fit@ParTable$lhs[regress]))
  }
  if(any(latent)) {
    observed_nodes <- c(observed_nodes, unique(fit@ParTable$rhs[latent]))
    latent_nodes <- c(latent_nodes, unique(fit@ParTable$lhs[latent]))
  }
  # make sure latent variables don't show up in both
  observed_nodes <- setdiff(observed_nodes, latent_nodes)

  # remove . from variable names
  observed_nodes <- stringr::str_replace_all(observed_nodes, pattern = "\\.", replacement = "")
  latent_nodes <- stringr::str_replace_all(latent_nodes, pattern = "\\.", replacement = "")

  list(observeds = observed_nodes, latents = latent_nodes)
}