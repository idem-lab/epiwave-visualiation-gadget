#' Title
#'
#' @param model 
#' @param pars 
#'
#' @returns
#' @export
#'
#' @examples
#' 
create_posterior_plot <- function(model, pars=NULL, param_map=NULL) {
  draw <- aperm(as.array(model$fit), c(1,3,2))
  
  if (is.null(pars) || length(pars) == 0) {
    pars <- dimnames(draw)[[3]]
  }
  
  if (!is.null(param_map)) {
    labels <- setNames(param_map$display_name, param_map$raw_name)
    new_names <- labels[pars]
    dimnames(draw)[[3]][dimnames(draw)[[3]] %in% pars] <- new_names
    pars <- new_names
  }
  
  bayesplot::mcmc_dens_overlay(draw, pars) # __PARS__
}

# RUN:
# create_posterior_plot(model, pars) # __CALL__
