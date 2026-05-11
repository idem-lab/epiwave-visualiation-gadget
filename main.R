
# Initial setup
pacman::p_load(greta, shiny, bslib, ggplot2, bayesplot)
R.utils::sourceDirectory('R/')

# Create x observation
observation_list <- list(
  Petal.Length = iris$Petal.Length,
  Petal.Width  = iris$Petal.Width,
  Sepal.Width  = iris$Sepal.Width
)

# Perform prior predictive check
prior_results <- prior_check(x_obs=observation_list,n_sims=100)

# Fit the model
fit_model <- fit_model(x=observation_list, y=iris$Sepal.Length)

# Map information into a data frame
info <- extract_model_info(fit_model, observation_list)

# Run the gadget
epiwaveVisualisationGadget(
  fit_model=fit_model, 
  info=info, 
  prior_results=prior_results)




