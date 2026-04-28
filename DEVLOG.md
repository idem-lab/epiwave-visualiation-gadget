# Development Log

(-) Done
(**) To be done

## 10 March

- Implemented a Bayesian regression posterior visualisation of the example model with greta, ggplot2 and piping
- Familiarised more with Bayesian workflow (Prior, Posterior, Likelihood)
- Understood the information given by summary(model)
- Created a simple Shiny app with a posterior distribution area plot with [shinycssloaders](https://github.com/daattali/shinycssloaders/)
and package `shinythemes`

** Understand mcmc sampling, t-distribution, chains


## 24 March

- Sketched basic architecture/essential components
- Segregated model fitting function & visualisation function
- Re-built knowledge about the purpose of the tool
- Researched about possible failures and model re-evaluating criteria

** In-depth visual prototyping of the App

## 31 March

### Software Architecture

### #5 Software Design

Software designed to have three (3) core modules/components:

  - `model.R` - A module that fits the model and returns a list variable of parameters
  - `epiwaveVisualisationGadget.R` - A function based on Shiny that takes the fit model output for visualisation
  - `main.R` - A main method to run the functions


Design is chosen for the following criteria:

  - SRP implementation: one script, one function
  - Abstraction/Simplicity: Allows the user to jump into the main method for a rough run before calibration 
  - Reproducibility/Reusability: Functions are not hard-coded for only specific data/values

** Simplification of post-run calibration (re-defining priors) 
** 2 Phases: Pre-run vs Post-run

- Create navbar and sidebar with a posterior distribution plot and a convergence plot

## 10 April

- Fix external CSS loading, removed Shiny theme
> link to CSS must be put outside the shiny bootstrap function (Ex.navbarpage()) to refrain from overlapping

** Or use includeCSS() for force-load

- Add sample prior predictive check plot for iris dataset

## 16 Apr 

- Created prior_predictive_check() to store sample parameters and create simulated y
to be passed on to the gadget for visualisation
- Changed the prior distribution accordingly to reasonable range
- Added prior predictive check plots:

1) y_rep simulation plot
2) line plot
3) ecdf plot

** Add better features for the plots for readability
** Integrate JS
** Time-series analysis
** Complete Posterior Checks

## 21 Apr

- Receive feedback and guidelines for the tasks
  - create helper functions
  - create sidebars (ex. coefficient grouping/checkbox, parameter checkbox)
  - create home page with text box for additional information and guidelines (landing page) * implemented, need content
  - convergence summary * to be implemented
  - modularise functions in Shiny to simplify logic in the gadget
  - allow the user to download and copy the code and image for the plot 
  
- created mapping.R and prepare_x()
- created dummy home page
- refactored main.R to only process x and y data without data processing; processing to be encapsulated in the functions
- refactored plots and logic to suit multivariate visualisation and processing


# 28 Apr

- Added external JS file
- Refactored the structure to resemble epiwave objects 
- Refactored 2 helper functions: map() and prepare_x() to a single `extract_model_info` to dynamically read and store coef and map the labels into one df
- Add working download plot and screenshot button in Shiny

** Work on prior_check (currently error)
** Work on sidebar - checkboxes and grouping
** Code for the plot download button
** Customise download button
