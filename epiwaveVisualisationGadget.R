
# A function that takes in a fit model and visualises it for evaluation 

epiwaveVisualisationGadget <- function(fit_model, info) {

# Define UI for application
ui <- fluidPage(
      tags$head(includeCSS("www/styles.css"),includeScript("www/script.js")), # external css
      
      navbarPage(
      id="main_nav",
      title="Epiwave",
      
      tabPanel(
        "Home"
        ),
      
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
      
        tabPanel("Convergence Diagnostics",
              sidebarLayout(
                  sidebarPanel(
                     sliderInput("num", label="Number Input:", min=1, value=20, max=40)
                    ),
                   mainPanel(
                     plotOutput("plot2"),
                     downloadButton("downloadPlot", "Download Plot"),
                     actionButton("go","Screenshot")
                   )
                )
            ),
      
        tabPanel("Posterior Predictive Check",
                 sidebarLayout(
                   sidebarPanel(
                     sliderInput("num", label="Number Input:", min=1, value=20, max=40)
                   ),
                   mainPanel(
                     plotOutput("plot3"),
                     downloadButton("downloadPlot2", "Download Plot"),
                     actionButton("go","Screenshot")
                   )
                )
            ) 
        ) #navbar
      
)

draw <- aperm(as.array(fit_model$fit),c(1,3,2))

# Define server logic 
server <- function(input, output, session) {
  
    # prior predictive check 
    # output$plot1 <- renderPlot({
    #   ggplot(prior_results$sim_data, aes(x = x, y = y_rep, group = sim)) +
    #     geom_line(alpha = 0.1, color = "red") +
    #     geom_hline(yintercept = range(y), linetype = "dashed", color = "blue") +
    #     theme_minimal() +
    #     
    #     labs(
    #       title = "Prior Predictive Samples",
    #       subtitle = "Simulated y values generated from prior parameter draws"
    #     )
    # })
    
    # convergence plot
  output$plot2 <- renderPlot({
    bayesplot::mcmc_trace(fit_model$fit)
  })
  
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste0("convergence-plot-", Sys.Date(), ".png")
    },
    contentType = "image/png",
    content = function(file) {
      png(file, width = 1200, height = 800, res = 150)
      
      p <- bayesplot::mcmc_trace(fit_model$fit)
      print(p)
      
      dev.off()
    }
  )
    
    observeEvent(input$go,{
      screenshot()
    })
    
    # Posterior
    output$plot3 <- renderPlot({
        bayesplot::mcmc_areas(draw, pars=info$pars)
        # scale_y_discrete(
        #   labels=fit$lab
        # ) +
        # labs(
        #   title="Posterior Distribution of model parameters",
        #   subtitle="Bayesian Regression Model"
        # ) +
        # theme_gray() +
        # theme(plot.title=element_text(hjust=0.5), plot.subtitle=element_text(hjust=0.5),
        #       panel.border=element_rect(linetype="dashed"))
    })

    
    output$downloadPlot2 <- downloadHandler(
      filename = function() {
        paste0("posterior-plot-", Sys.Date(), ".png")
      },
      contentType = "image/png",
      content = function(file) {
        png(file, width = 1200, height = 800, res = 150)
        
        d <- bayesplot::mcmc_areas(draw, pars=info$pars)
        print(d)
        
        dev.off()
      }
    )
    
  }

# Run the application 
  shinyApp(ui = ui, server = server)
}



# server <- function(input, output) {
#   # Create plot as a reactive to avoid repeating code
#   plotInput <- reactive({
#     ggplot(mtcars, aes(wt, mpg)) + geom_point()
#   })
