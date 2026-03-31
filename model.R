#
# A function that takes observed data as input and returns a fitted model.
#
#
fit_model <- function (x, y, n_samples=1000,chains=4) {
  
  # Observations
  x <- as_data(x)
  y <- as_data(y)
  
  # Priors
  int <- normal(0,1)
  coef <- normal(0,3)
  sd <- student(df=3,mu=0,sigma=1,truncation=c(0,Inf))
  
  mean <- int + coef * x
  distribution(y) <- normal(mean,sd)
  m <- model(int, coef, sd)
  
  draws <- mcmc(m, n_samples = n_samples, chains = chains)
  
  # Output - multiple values stored in a list
  list(
    model = m,
    draws = draws,
    pars = c("int","coef","sd"),
    lab = c("Intercept", "Weight", "Noise Level")
  )
}



