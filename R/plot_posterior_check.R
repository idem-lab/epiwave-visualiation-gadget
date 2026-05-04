#
# A function to create posterior plot 
#

create_posterior_plot <- function(model, pars=NULL) {
  draw <- aperm(as.array(model$fit),c(1,3,2))
  
  if (is.null(pars) || length(pars) == 0) {
    pars <- dimnames(draw)[[3]]
  }
  bayesplot::mcmc_areas(draw, pars)
}

