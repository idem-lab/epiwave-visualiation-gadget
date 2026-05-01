

epiwaveVisualisationGadget <- function(fit_model=NULL, 
                                       info=NULL, 
                                       prior_results=NULL) {

# Define UI for application
ui <- fluidPage(
      tags$head(includeCSS("www/styles.css"), includeScript("www/script.js")), # external css
      
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
                   plotOutput("plotPriorParam"),
                   downloadButton("downloadPriorParam", "Download Plot"),
                   downloadButton("downloadPriorParamCode", "Download Code"),
                   actionButton("copyPriorCode", "Copy Code"),
                   actionButton("go","Screenshot")
                 )
              )
      ),
      
        tabPanel("Convergence Diagnostics",
              sidebarLayout(
                  sidebarPanel(
                     sliderInput("num", label="Number Input:", min=1, value=20, max=40)
                    ),
                   mainPanel(
                     plotOutput("plotConv"),
                     downloadButton("downloadConv", "Download Plot"),
                     downloadButton("downloadConvCode", "Download Code"),
                     actionButton("go","Screenshot"),
                     actionButton("copyConvCode", "Copy Code")
                   )
                )
            ),
      
        tabPanel("Posterior Predictive Check",
                 sidebarLayout(
                   sidebarPanel(
                     sliderInput("num", label="Number Input:", min=1, value=20, max=40)
                   ),
                   mainPanel(
                     plotOutput("plotPost"),
                     downloadButton("downloadPost", "Download Plot"),
                     downloadButton("downloadPostCode", "Download Code"),
                     actionButton("copyPostCode", "Copy Code"),
                     actionButton("go","Screenshot")
                   )
                )
            ) 
        ) #navbar
      
)

# Define server logic 
server <- function(input, output, session) {
  
  #
  # Prior Predictive Check plot
  #
  
  prior_param_plot <- reactive({
    plot_prior_params(prior_results)
  })
  output$plotPriorParam <- renderPlot({
    prior_param_plot()
  })
  output$downloadPriorParam <- download_plot_img(
    p=prior_param_plot, fname="prior-param-plot"
  )
  output$downloadPriorParamCode <- download_plot_code("plot_prior_check.R")
  
  #
  # Convergence plot
  #
  
  convergence_plot <- reactive({
    create_convergence_plot(fit_model$fit)
  })
  output$plotConv <- renderPlot({
    convergence_plot()
  })
  output$downloadConv <- download_plot_img(
    p=convergence_plot, fname="convergence-plot"
  )
  output$downloadConvCode <- download_plot_code("plot_convergence.R")
  
  observeEvent(input$copyConvCode,{
    copy_plot_code("plot_convergence.R")
  })
  # Allow user to screenshot the current page of the App
  observeEvent(input$go,{screenshot()})
  
  
    
  #
  # Posterior plot
  #
  
  posterior_plot <- reactive({
    create_posterior_plot(fit_model, pars=info$pars)
  })
  output$plotPost <- renderPlot({
    posterior_plot()
  })
  output$downloadPost <- download_plot_img(
    posterior_plot, "posterior-plot"
  )
  output$downloadPostCode <- download_plot_code("plot_posterior_check.R")
  observeEvent(input$go,{screenshot()})

  
}

# Run the application 
  shinyApp(ui = ui, server = server)
}
