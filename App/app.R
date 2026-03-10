# Simple Shiny App for the example model

# Dependencies
# install.packages("shinythemes")

library(shiny)
library(greta)
library(bayesplot)
library(tidyverse)
library(bslib)
library(shinythemes)

# UI
ui <- fluidPage(
    theme=shinytheme("flatly"),

    # Application title
    titlePanel("Iris Dataset: Posterior Parameters Distribution"),
    
        # Show a plot of the generated distribution
        mainPanel(
          shinycssloaders::withSpinner(
           plotOutput("plot")
        )
    )
)

# Define server logic
server <- function(input, output) {

    output$plot <- renderPlot({
      x <- as_data(iris$Petal.Length)
      y <- as_data(iris$Sepal.Length)
      
      int <- normal(0,1) # intercept
      coef <- normal(0,3) # weight
      sd <- student(df=3,mu=0,sigma=1, truncation = c(0, Inf))
      
      mean <- int + coef * x
      distribution(y) <- normal(mean,sd)
      m <- model(int,coef,sd)
      
      draws <- mcmc(m, n_samples = 1000)
      
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
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
