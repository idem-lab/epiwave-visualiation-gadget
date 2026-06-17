#' Run prior predictive checks
#'
#' Simulates data from the model priors before fitting the model. The output is
#' used to check whether the chosen priors generate reasonable values.
#'
#' @param x_obs Predictor variables used in the model.
#' @param y Optional observed response variable. Currently unused.
#' @param n_sims Number of prior simulations to generate. Default is 100.
#'
#' @returns A list containing prior parameter samples and simulated response data.
#'
#' @export
#'
#' @examples
#' prior_results <- prior_check(x_obs=observation_list,n_sims=100)
prior_check <- function(x_obs, y = NULL, n_sims = 100) {
  x_mat <- as.matrix(data.frame(x_obs))
  n_obs  <- nrow(x_mat)
  p      <- ncol(x_mat)
  
  # priors
  int  <- normal(5.5, 0.5)
  coef <- normal(0.5, 0.2, dim = p)
  sd   <- normal(0, 0.4, truncation = c(0, Inf))
  
  # simulate
  int_sim  <- as.numeric(calculate(int,  nsim = n_sims)$int)
  coef_sim <- matrix(as.numeric(calculate(coef, nsim = n_sims)$coef), nrow = n_sims, ncol = p)
  sd_sim   <- as.numeric(calculate(sd,   nsim = n_sims)$sd)
  
  coef_names <- paste0("coef[", 1:p, ",1]")
  
  # raw names from the start — no renaming later
  prior_samples <- data.frame(
    sim = 1:n_sims,
    int = int_sim,
    coef_sim,
    sd  = sd_sim
  )
  colnames(prior_samples) <- c("sim", "int", coef_names, "sd")
  
  sim_data <- do.call(rbind, lapply(1:n_sims, function(i) {
    mu    <- int_sim[i] + x_mat %*% coef_sim[i, ]
    y_rep <- rnorm(n_obs, mean = mu, sd = sd_sim[i])
    data.frame(sim = i, x_mat, y_rep = as.numeric(y_rep))
  }))
  
  list(prior_samples = prior_samples, sim_data = sim_data)
}