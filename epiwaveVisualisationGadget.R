

# A function that takes in a fit model and visualises it for evaluation 
epiwaveVisualisationGadget <- function(fit) {

# Define UI for application
ui <- fluidPage(
  
      tags$head(includeCSS("www/styles.css")), # external css
      
      navbarPage(
      title="Epiwave",
      tabPanel("Prior Predictive Check",
               sidebarLayout(
                 sidebarPanel(
                   sliderInput("num", label="Number Input:", min=1, value=20, max=40)
                 ),
                 mainPanel(
                   plotOutput("plot1")
                 )
              )
      ),
      
        tabPanel("Convergence Plot",
              sidebarLayout(
                  sidebarPanel(
                     sliderInput("num", label="Number Input:", min=1, value=20, max=40)
                    ),
                   mainPanel(
                     plotOutput("plot2")
                   )
                )
            ),
      
        tabPanel("Posterior Predictive Check",
                 sidebarLayout(
                   sidebarPanel(
                     sliderInput("num", label="Number Input:", min=1, value=20, max=40)
                   ),
                   mainPanel(
                     plotOutput("plot3")
                   )
                )
            ) 
        ) #navbar
      
)

# Define server logic 
server <- function(input, output, session) {
  
    draw <- aperm(as.array(fit$draws),c(1,3,2))
    
    
    output$plot1 <- renderPlot({
      bayesplot::mcmc_trace(fit$draws)
    })
    
    output$plot2 <- renderPlot({
      bayesplot::mcmc_trace(fit$draws)
    })

    output$plot3 <- renderPlot({
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