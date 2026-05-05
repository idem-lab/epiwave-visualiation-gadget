# convert greta object to stan

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