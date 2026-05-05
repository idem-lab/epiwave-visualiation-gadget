diagnose_model <- function(fitted_model,
                           rhat_threshold = 1.1,
                           eff_sample_threshold = 100) {
  
  # if (!inherits(fitted_model, "epiwave.fit")) {
  #   stop("fitted_model must be an epiwave.fit object")
  # }
  
  validate_rhat_threshold(rhat_threshold)
  validate_eff_sample_threshold(eff_sample_threshold)
  
  # Get model summary #FIXME
  # fit_summary <- rstan::summary(fitted_model$fit)$summary
  
  fit_summary <- fitted_model$fit_summary
  
  # Check R-hat values
  rhat_values <- fit_summary[, "Rhat"]
  rhat_issues <- names(rhat_values)[rhat_values > rhat_threshold & !is.na(rhat_values)]
  
  # Check effective sample sizes
  n_eff_values <- fit_summary[, "n_eff"]
  eff_sample_issues <- names(n_eff_values)[n_eff_values < eff_sample_threshold & !is.na(n_eff_values)]
  
  # Overall convergence assessment
  convergence <- length(rhat_issues) == 0 && length(eff_sample_issues) == 0
  
  # Additional diagnostics
  max_rhat <- max(rhat_values, na.rm = TRUE)
  min_neff <- min(n_eff_values, na.rm = TRUE)
  
  diagnostics <- list(
    convergence = convergence,
    rhat_issues = rhat_issues,
    eff_sample_issues = eff_sample_issues,
    max_rhat = max_rhat,
    min_neff = min_neff,
    summary = fit_summary
  )
  
  # Print summary
  cat("Model Convergence Diagnostics\n")
  cat("=============================\n")
  cat("Overall convergence:", ifelse(convergence, "GOOD", "ISSUES DETECTED"), "\n")
  cat("Maximum R-hat:", round(max_rhat, 3), "\n")
  cat("Minimum n_eff:", round(min_neff, 0), "\n")
  
  return(invisible(diagnostics))
}
