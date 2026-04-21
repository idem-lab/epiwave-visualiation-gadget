
# Model fitting function
fit_model <- function (x, y, n_samples=1000,chains=4) {

  # Observations
  x <- as_data(x)
  y <- as_data(y)

  # calibrated priors
  int <- normal(5.5, 0.5)
  coef <- normal(0.5, 0.2, dim = 2)
  sd <- normal(0, 0.4, truncation = c(0, Inf))

  mean <- int + x %*% coef
  distribution(y) <- normal(mean,sd) # posterior distribution
  m <- model(int, coef, sd)

  # posterior samples
  draws <- mcmc(m, n_samples = n_samples, chains = chains)

  # Output - multiple values stored in a list
  list(
    model = m,
    draws = draws,
    pars = colnames(draws[[1]]), #c("int","coef","sd"),
    lab = c("Intercept", "Slope1", "Slope2", "Noise Level")
  )
}



