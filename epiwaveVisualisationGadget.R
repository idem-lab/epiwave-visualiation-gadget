

# A function that takes in a fit model and visualises it for evaluation 
epiwaveVisualisationGadget <- function(fit, prior_result) {

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
                   plotOutput("plot1"),
                   plotOutput("plotb")
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

x <- iris$Petal.Length
y <- iris$Sepal.Length

#prior_result <- prior_predictive_check(x,y,n_sims = 100)
draw <- aperm(as.array(fit$draws),c(1,3,2))

# Define server logic 
server <- function(input, output, session) {
  
    # x <- iris$Petal.Length
    # y <- iris$Sepal.Length
    # 
    # prior_result <- prior_predictive_check(x,y,n_sims = 100)
    # draw <- aperm(as.array(fit$draws),c(1,3,2))
    
    # prior predictive check 
    output$plot1 <- renderPlot({
      ggplot(prior_result$sim_data, aes(x = x, y = y_rep, group = sim)) +
        geom_line(alpha = 0.1, color = "red") +
        geom_hline(yintercept = range(y), linetype = "dashed", color = "blue") +
        theme_minimal() +
        labs(
          title = "Prior Predictive Samples",
          subtitle = "Simulated y values generated from prior parameter draws"
        )
    })
    
    # line plot
    output$plotb <- renderPlot({
      p <- ggplot(data.frame(x=x,y=y),aes(x=x,y=y))+
        geom_abline(data=prior_result$prior_samples,aes(intercept=int,slope=coef),
                    color="red",alpha=0.2)
      if (!is.null(y)) {
        p <- p + geom_point(size = 2)
      }
      p
    })
    
    # convergence plot
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