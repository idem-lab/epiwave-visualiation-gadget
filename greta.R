# Installations
devtools::install_github("greta-dev/greta") 
library(greta)
install_greta_deps() # python conda env

# Plotting
install.packages("igraph") 
install.packages("DiagrammeR")
install.packages("bayesplot")
library(bayesplot)
library(tidyverse)

# x,y -> observed values (data)
# int,coef,sd -> unknown quantities (parameters)
#
# Building a Bayesian linear regression model for Iris data
# Creates a probability curve/probabilistic graph
# To obtain a set of ideal parameters
#
#
x <- as_data(iris$Petal.Length) # as_data() -> convert to greta arrays
y <- as_data(iris$Sepal.Length)

# Priors
#
# Define 'probable' distribution for the parameters which is yet unknown
#
int <- normal(0,1) # Intercept
coef <- normal(0,3) # Weightß
sd <- student(df=3,mu=0,sigma=1, truncation = c(0, Inf)) # Noise level

mean <- int + coef * x

# Likelihood
#
# How data is **assumed** to be generated
#
distribution(y) <- normal(mean,sd)

m <- model(int,coef,sd) # Creates a directed graphical model
plot(m)

# Sampling
#
# Computes the posterior distribution given observed data
#
draws <- mcmc(m, n_samples = 1000)
summary(draws)ß


# Example model + Visualisation
bayesplot::mcmc_areas(draws) + ggplot2::scale_y_discrete(
  labels=c("intercept","coefficient","standard deviation")) +
  ggplot2::labs(
    title="Posterior Distribution of model parameters",
    subtitle="Bayesian Regression model") + 
  theme_gray() +
  ggplot2::theme(plot.title=element_text(hjust=0.5), 
                     plot.subtitle=element_text(hjust=0.5),
                 panel.border=element_rect(linetype="dashed"))

# With Piping
piped_draw <- aperm(as.array(draws),c(1,3,2))
piped_draw %>%
  bayesplot::mcmc_areas(pars=c("int","coef","sd")) +
  scale_y_discrete(
    labels=c("Intercept","Weight","Noise Level")
  ) +
  labs(
    title="Posterior Distribution of model parameters",
    subtitle="Bayesian Regression Model"
  ) +
  theme_gray() +
  theme(plot.title=element_text(hjust=0.5), plot.subtitle=element_text(hjust=0.5),
        panel.border=element_rect(linetype="dashed"))


mcmc_trace(draws, facet_args = list(nrow = 3, ncol = 1))
mcmc_intervals(draws)

draws <- mcmc(m, n_samples = 1000, chains = 4)
bayesplot::mcmc_trace(draws)







