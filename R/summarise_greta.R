#' Summarise a fitted Greta model
#'
#' Converts Greta posterior samples into a summary matrix containing
#' parameter estimates and convergence diagnostics. This format is used
#' throughout the package by diagnostic and visualisation functions.
#'
#' @param fit A fitted Greta model object.
#'
#' @returns A matrix containing the posterior mean, standard deviation,
#' R-hat, and effective sample size for each parameter.
#'
#' @export
#'
#' @examples
#' fit_summary <- summarise_greta(fit)
summarise_greta <- function(fit) {
  draws <- posterior::as_draws(fit)
  
  out <- posterior::summarise_draws(
    draws,
    mean=mean,
    sd=sd,
    Rhat=posterior::rhat,
    n_eff=posterior::ess_bulk
  )
  
  mat <- as.matrix(out[, c("mean", "sd", "Rhat", "n_eff")])
  rownames(mat) <- out$variable
  mat
}