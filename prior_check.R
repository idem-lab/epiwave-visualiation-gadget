prior_check <- function(x_obs, y = NULL, n_sims = 100) {
  
  # make x into matrix
  x_mat <- as.matrix(data.frame(x_obs))
  n_obs <- nrow(x_mat)
  p <- ncol(x_mat)
  
  # get predictor names
  predictor_names <- colnames(x_mat)
  if (is.null(predictor_names)) {
    predictor_names <- paste0("x", 1:p)
  }
  
  # priors
  int  <- normal(5.5, 0.5)
  coef <- normal(0.5, 0.2, dim = p)
  sd   <- normal(0, 0.4, truncation = c(0, Inf))
  
  # simulate prior parameter values
  int_sim  <- as.numeric(calculate(int, nsim = n_sims)$int)
  coef_sim <- matrix(
    as.numeric(calculate(coef, nsim = n_sims)$coef),
    nrow = n_sims,
    ncol = p
  )
  sd_sim <- as.numeric(calculate(sd, nsim = n_sims)$sd)
  
  # save prior parameter samples
  prior_samples <- data.frame(
    sim = 1:n_sims,
    Intercept = int_sim,
    coef_sim,
    Noise = sd_sim
  )
  
  colnames(prior_samples) <- c(
    "sim",
    "Intercept",
    predictor_names,
    "Noise"
  )
  
  # simulate y values from priors
  sim_data <- do.call(rbind, lapply(1:n_sims, function(i) {
    
    mu <- int_sim[i] + x_mat %*% coef_sim[i, ]
    y_rep <- rnorm(n_obs, mean = mu, sd = sd_sim[i])
    
    data.frame(
      sim = i,
      x_mat,
      y_rep = as.numeric(y_rep)
    )
  }))
  
  colnames(sim_data)[2:(p + 1)] <- predictor_names
  
  return(list(
    prior_samples = prior_samples,
    sim_data = sim_data,
    predictor_names = predictor_names
  ))
}