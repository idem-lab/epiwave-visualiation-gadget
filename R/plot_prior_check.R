plot_prior_params <- function(prior_results, pars = NULL) {
  
  params_long <- prior_results$prior_samples |>
    dplyr::select(-sim) |>
    tidyr::pivot_longer(everything(), names_to = "parameter", values_to = "value")
  
  # filter by selected pars
  if (!is.null(pars) && length(pars) > 0) {
    params_long <- params_long |> dplyr::filter(parameter %in% pars)
  }
  
  ggplot(params_long, aes(x = value)) +
    geom_histogram(bins = 40, fill = "#4C72B0", alpha = 0.75) +
    facet_wrap(~parameter, scales = "free") +
    labs(title = "Prior distributions", x = "Parameter value", y = "Count") +
    theme_minimal()
}