#' Plot posterior density distributions for selected parameters
#'
#' @param model A fitted model object containing a `fit` element compatible
#'   with `as.array()` (e.g. an rstan/CmdStanR-style fit with chain draws).
#' @param pars A vector of parameter names to plot. If `NULL`, all
#'   parameters in the fit are plotted.
#' @param param_map Optional data frame mapping raw parameter names to
#'   display names (with `raw_name` and `display_name` columns).
#'
#' @returns A `bayesplot`/ggplot object showing overlaid posterior density
#'   plots by chain
#' @export
#'
#' @examples
#' posterior_plot <- reactive({create_posterior_plot(fit_model, pars=input$postPars)})
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
