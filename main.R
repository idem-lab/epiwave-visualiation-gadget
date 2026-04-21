
# Dependencies
library(greta)
library(shiny)
library(shinythemes)
library(ggplot2)
library(bayesplot)

source('fit_model.R')
source('prior.R')
source('epiwaveVisualisationGadget.R')

# Populate with real data and store return values in a variable
x_mat <- cbind(iris$Petal.Length, iris$Sepal.Width)
fit <- fit_model(x_mat, iris$Sepal.Length)

# Prior Predictive Checks
lines_df <- priors(iris$Petal.Length)

# Take the variable as an input and run the gadget
epiwaveVisualisationGadget(fit)


