
# Dependencies
library(greta)
library(shiny)
library(shinythemes)
library(ggplot2)
library(bayesplot)

# Populate with real data and store return values in a variable
fit <- fit_model(iris$Petal.Length,iris$Sepal.Length)

# Prior Predictive Checks
lines_df <- priors(iris$Petal.Length)

# Take the variable as an input and run the gadget
epiwaveVisualisationGadget(fit)


