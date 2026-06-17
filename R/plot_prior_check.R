#' Plot prior distributions for selected parameters
#'
#' @param prior_results A list containing prior samples
#' @param pars A vector of parameter names to plot
#' @param param_map Optional data frame mapping raw parameter names to
#'   display names (with `raw_name` and `display_name` columns).
#'
#' @returns A ggplot object
#' @export
#'
#' @examples
#' prior_param_plot <- reactive({plot_prior_params(prior_results,pars=input$priorPars)})
plot_prior_params <- function(prior_results, pars=NULL, param_map=NULL) {
  
  samples <- prior_results$prior_samples |> dplyr::select(-sim)
  
  if (!is.null(pars) && length(pars) > 0) {
    samples <- samples |> dplyr::select(dplyr::all_of(pars)) # __PARS__
  }
  
  if (!is.null(param_map)) {
    labels <- setNames(param_map$display_name, param_map$raw_name)
    colnames(samples) <- ifelse(colnames(samples) %in% names(labels),
                                labels[colnames(samples)],
                                colnames(samples))
  }
  
  params_long <- samples |>
    tidyr::pivot_longer(everything(), names_to = "parameter", values_to = "value")
  
  ggplot(params_long, aes(x = value)) +
    geom_density(fill = "#4C72B0", alpha = 0.75) +
    geom_rug(alpha=0.1)+
    facet_wrap(~parameter, scales = "free") +
    labs(title = "Prior distributions", x = "Value", y = "Density") +
    theme_minimal()
}

# Run
# plot_prior_params(prior_results, pars=c('int)) # __CALL__

