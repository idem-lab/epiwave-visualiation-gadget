#
# A function to create convergence plot 
#

library(bayesplot)
library(ggplot2)

create_convergence_plot <- function(model) {
  bayesplot::mcmc_trace(model)
}
