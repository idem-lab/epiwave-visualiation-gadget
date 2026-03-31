

# A function that takes in a fit model and visualises it for evaluation 
epiwaveVisualisationGadget <- function(fit) {

# Define UI for application
ui <- fluidPage(
  theme=shinytheme("flatly"),
    # Application title
    titlePanel("Model Evaluation"),
    mainPanel(
     plotOutput("plot1")
    )
)

# Define server logic 
server <- function(input, output, session) {
  
    draw <- aperm(as.array(fit$draws),c(1,3,2))

    output$plot1 <- renderPlot({
        bayesplot::mcmc_areas(draw, pars=fit$pars) +
        scale_y_discrete(
          labels=fit$lab
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

}
