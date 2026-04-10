

# Prior predictive check function
prior_check <- function(x, y = NULL, n_sims = 100) {
  
  # observed x only
  x_data <- x
  
  # greta version of x for consistency with model structure
  x <- as_data(x)
  
  # same priors as fit_model()
  int <- normal(0, 1)
  coef <- normal(0, 3)
  sd <- student(df = 3, mu = 0, sigma = 1, truncation = c(0, Inf))
  
  # sample from priors
  int_sim  <- calculate(int, nsim = n_sims)
  coef_sim <- calculate(coef, nsim = n_sims)
  sd_sim   <- calculate(sd, nsim = n_sims)
  
  # make dataframe of sampled prior parameters
  prior_lines <- data.frame(
    intercept = as.numeric(int_sim$int),
    slope = as.numeric(coef_sim$coef),
    sd = as.numeric(sd_sim$sd)
  )
  
  # base plot
  p <- ggplot(data.frame(x = x_data, y = y), aes(x = x, y = y)) +
    geom_abline(
      data = prior_lines,
      aes(intercept = intercept, slope = slope),
      color = "red",
      alpha = 0.2
    ) +
    theme_minimal() +
    labs(
      title = "Prior Predictive Check",
      subtitle = "Lines sampled from the prior distributions"
    )
  
  # only add points if y is given
  if (!is.null(y)) {
    p <- p + geom_point(size = 3)
  }
  
  return(list(
    prior_draws = prior_lines,
    plot = p
  ))
}