#' Fit the model
#'
#' @param x 
#' @param y 
#' @param n_samples 
#' @param chains 
#'
#' @returns 
#' @export
#'
#' @examples
fit_model <- function (x, y, n_samples=1000,chains=4) {
  
  # Convert to greta data object
  x_data <- as_data(as.matrix(data.frame(x)))
  y_data <- as_data(y)
  
  p <- ncol(as.matrix(data.frame(x)))
  
  # priors
  int <- normal(5.5, 0.5)
  coef <- normal(0.5, 0.2, dim = p)
  sd <- normal(0, 0.4, truncation = c(0, Inf))
  
  mean <- int + x_data %*% coef
  distribution(y_data) <- normal(mean,sd) 
  
  # Fit the model
  m <- model(int, coef, sd)
  fit <- mcmc(m, n_samples = n_samples, chains = chains)
  
  # Convert mcmc fit object in rstan style 
  fit_summary <- summarise_greta(fit)
  
  fit_output <- list(
    model=m,
    fit=fit,
    fit_summary=fit_summary
  )
  
  return(fit_output)
}



