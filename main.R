
install.packages("shinyscreenshot")

# Dependencies
library(greta)
library(shiny)
library(bslib)
library(shinythemes)
library(ggplot2)
library(bayesplot)
library(shinyscreenshot)

source('fit_model.R')
source('prior_check.R')
source('epiwaveVisualisationGadget.R')
source('test.R')

# quick replica of define_observation_model output
observation_list <- list(
  Petal.Length = iris$Petal.Length,
  Petal.Width  = iris$Petal.Width,
  Sepal.Width  = iris$Sepal.Width
)

# Fit the model
# only return model and mcmc draws - no helper functions included as epiwave doesn't
fit_model <- fit_model(x=observation_list, y=iris$Sepal.Length)

# map labels into a data frame
info <- extract_model_info(fit_model, observation_list)

# Prior Predictive Checks
prior_results <- prior_check(x=observation_list)

# Take the variable as an input and run the gadget
epiwaveVisualisationGadget(fit_model, info)


