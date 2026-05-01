#
# Functions to create various plot for prior predictive checks
#

plot_prior_params <- function(prior_results) {
  
  # drop sim column, pivot to long
  params_long <- prior_results$prior_samples |>
    dplyr::select(-sim) |>
    tidyr::pivot_longer(everything(), 
                        names_to  = "parameter", 
                        values_to = "value")
  
  ggplot(params_long, aes(x = value)) +
    geom_histogram(bins = 40, fill = "#4C72B0", alpha = 0.75) +
    facet_wrap(~parameter, scales = "free") +
    labs(
      title    = "Prior distributions",
      #subtitle = "Sampled directly from priors — before seeing any data",
      x = "Parameter value", y = "Count"
    ) +
    theme_minimal()
}