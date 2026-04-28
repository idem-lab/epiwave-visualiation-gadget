
# Function to fit model and return fit obj
# Assume that x == list
fit_model <- function (x, y, n_samples=1000,chains=4) {
  
  # set up the greta model
  x_data <- as_data(as.matrix(data.frame(x)))
  y_data <- as_data(y)
  
  p <- ncol(as.matrix(data.frame(x)))
  
  # priors
  int <- normal(5.5, 0.5)
  coef <- normal(0.5, 0.2, dim = p)
  sd <- normal(0, 0.4, truncation = c(0, Inf))
  
  mean <- int + x_data %*% coef
  distribution(y_data) <- normal(mean,sd) 
  
  # greta model fit
  m <- model(int, coef, sd)
  fit <- mcmc(m, n_samples = n_samples, chains = chains)
  
  # return the outputs
  fit_output <- list(
    model=m,
    fit=fit
    # more return values in epiwave
    # pars=colnames(fit[[1]])
  )
  
  return(fit_output)
}



