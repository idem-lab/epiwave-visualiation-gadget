#
# A function to create convergence plot 
#

create_convergence_plot <- function(model, pars=NULL) {
  if (is.null(pars) || length(pars) == 0) {
    pars <- colnames(model[[1]]) # Use all parameters when not given any input
  }
  bayesplot::mcmc_trace(model, pars=pars)
}
