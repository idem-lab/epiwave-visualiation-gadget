
# Prior predictive check 
prior_predictive_check <- function(x, y = NULL, n_sims = 100) {
  
  x_data <- x 
  
  # calibrated priors
  int <- normal(5.5, 0.5)
  coef <- normal(0.5, 0.2)
  sd <- normal(0, 0.4, truncation = c(0, Inf))
  
  # n times sampling from priors
  int_sim  <- as.numeric(calculate(int, nsim = n_sims)$int)
  coef_sim <- as.numeric(calculate(coef, nsim = n_sims)$coef)
  sd_sim   <- as.numeric(calculate(sd, nsim = n_sims)$sd)
  
  # n times sampled parameters 
  prior_samples <- data.frame(
    sim=1:n_sims,
    int=int_sim,
    coef=coef_sim,
    sd=sd_sim
  )
  
  # predicted y from observed x and sample parameters
  sim_data <- do.call(rbind, lapply(1:n_sims, function(i) {
    mu <- int_sim[i] + coef_sim[i] * x_data # average line y with params[i]th
    y_rep <- rnorm(length(x_data), mean = mu, sd = sd_sim[i]) # fake y noise likelihood
    
    data.frame(
      sim = i,
      x = x_data,
      y_rep = y_rep
    )
  }))
  
  return(list(
    prior_samples = prior_samples,
    sim_data = sim_data
  ))
  
}



