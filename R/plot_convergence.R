#' Plot convergence diagnostics for MCMC chains
#'
#' @param model A fitted model object, either containing a `fit` element
#'   (a list of per-chain matrices) or being such a list directly.
#' @param pars A vector of parameter names to plot. If `NULL`, all
#'   parameters in the fit are plotted.
#' @param param_map Optional data frame mapping raw parameter names to
#'   display names (with `raw_name` and `display_name` columns).
#'
#' @returns A `bayesplot`/ggplot object showing MCMC trace plots by chain
#' @export
#'
#' @examples
#'   convergence_plot <- reactive({create_convergence_plot(fit_model$fit,pars=input$convPars)})
create_convergence_plot <- function(model, pars=NULL, param_map=NULL) {
  
  if (!is.null(model$fit)) {
    model <- model$fit
  }
  
  if (is.null(pars) || length(pars) == 0) {
    pars <- colnames(model[[1]])
  }
  
  if (!is.null(param_map)) {
    labels <- setNames(param_map$display_name, param_map$raw_name)
    pars <- ifelse(pars %in% names(labels), labels[pars], pars)
    model <- setNames(lapply(model, function(chain) {
      colnames(chain) <- labels[colnames(chain)]
      chain
    }), names(model))
  }
  bayesplot::mcmc_trace(model, pars=pars) # __PARS__
}

# RUN:
# create_convergence_plot(model, pars) # __CALL__
