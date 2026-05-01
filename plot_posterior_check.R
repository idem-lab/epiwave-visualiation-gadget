#
# A function to create posterior plot 
#

library(bayesplot)
library(ggplot2)

create_posterior_plot <- function(model, pars) {
  draw <- aperm(as.array(model$fit),c(1,3,2))
  bayesplot::mcmc_areas(draw, pars)
}