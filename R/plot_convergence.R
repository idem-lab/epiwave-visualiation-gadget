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
