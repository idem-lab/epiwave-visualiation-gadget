#' Title
#'
#' @param fit_model 
#' @param info 
#' @param prior_results 
#'
#' @returns
#' @export
#'
#' @examples
epiwaveVisualisationGadget <- function(fit_model=NULL, 
                                       info=NULL, 
                                       prior_results=NULL) {

text <- readLines("homepage.txt")
f_csv <- read.csv("data.csv")

# Define UI for application
ui <- fluidPage(
      tags$head(includeCSS("www/styles.css"), includeScript("www/script.js")), # external css
      
      navbarPage(id="main_nav", title="Epiwave",
      
      tabPanel(
        "Home",
        verbatimTextOutput("txtDisplay"),
        tableOutput("csvDisplay")
        ),
      
      tabPanel("Prior Predictive Check",
               sidebarLayout(
                 sidebarPanel(
                   checkboxGroupInput(
                     inputId = "priorPars",
                     label = "Parameters:",
                     choices = setNames(
                       info$param_map$raw_name,
                       info$param_map$display_name),
                     selected = info$param_map$raw_name
                     )
                   ),
                mainPanel(
                   plotOutput("plotPriorParam"),
                   div( id ="buttons",
                   downloadButton("downloadPriorParam", "Download Plot"),
                   downloadButton("downloadPriorParamCode", "Download Code"),
                   actionButton("copyPriorCode", "Copy Code"),
                   actionButton("ssPrior","Screenshot")
                 ))
              )),
      
        tabPanel("Convergence Diagnostics",
              sidebarLayout(
                  sidebarPanel(
                     checkboxGroupInput(
                       "convPars", label="Parameters:",choices=setNames(
                         info$param_map$raw_name,
                         info$param_map$display_name),
                       selected=info$param_map$raw_name
                     )
                    ),
                  mainPanel(
                     htmlOutput("diagBadges"),
                     plotOutput("plotConv"),
                     div( id ="buttons",
                     downloadButton("downloadConv", "Download Plot"),
                     downloadButton("downloadConvCode", "Download Code"),
                     actionButton("copyConvCode", "Copy Code"),
                     actionButton("ssConv","Screenshot")
                   ))
                )
            ),
      
        tabPanel("Posterior Predictive Check",
                 sidebarLayout(
                   sidebarPanel(
                     checkboxGroupInput(
                       "postPars", label="Parameters:",
                       choices  = setNames(info$param_map$raw_name, 
                                           info$param_map$display_name),
                       selected = info$param_map$raw_name
                     )
                   ),
                   mainPanel(
                     plotOutput("plotPost"),
                     div( id ="buttons",
                     downloadButton("downloadPost", "Download Plot"),
                     downloadButton("downloadPostCode", "Download Code"),
                     actionButton("copyPostCode", "Copy Code"),
                     actionButton("ssPost","Screenshot")
                     )
                   )
                )
            ) 
      ) #navbar
)


# Define server logic 
server <- function(input, output, session) {
  
  output$txtDisplay <- renderText({paste(text,collapse="\n")})
  output$csvDisplay <- renderTable(f_csv)
  
  #
  # Prior Predictive Check plot
  #
  
  prior_param_plot <- reactive({
    plot_prior_params(prior_results,pars=input$priorPars)
  })
  output$plotPriorParam <- renderPlot({
    prior_param_plot()
  })
  output$downloadPriorParam <- download_plot_img(
    p=prior_param_plot, fname="prior-param-plot"
  )
  output$downloadPriorParamCode <- download_plot_code("R/plot_prior_check.R")
  
  observeEvent(input$copyPriorCode,{
    copy_plot_code("R/plot_prior_check.R", session)
  })
  observeEvent(input$ssPrior,{screenshot()})
  
  #
  # Convergence plot
  #
  
  
  badge <- function(label, value, status) {
    tags$div(
      class = paste("diag-badge", paste0("diag-", status)),
      tags$span(class = "diag-badge-label", label),
      tags$span(class = "diag-badge-value", value)
    )
  }
  
  output$diagBadges <- renderUI({
    max_rhat  <- max(fit_model$fit_summary[, "Rhat"],  na.rm = TRUE)
    min_neff  <- min(fit_model$fit_summary[, "n_eff"], na.rm = TRUE)
    converged <- max_rhat < 1.1 && min_neff > 100
    
    tags$div(
      class = "diag-badge-container",
      badge("Overall",   if (converged) "Converged" else "Issues detected",
            if (converged) "success" else "danger"),
      badge("Max R-hat", round(max_rhat, 3),
            if (max_rhat < 1.1) "neutral" else "warning"),
      badge("Min n_eff", round(min_neff, 0),
            if (min_neff > 100) "neutral" else "warning")
    )
  })
  
  convergence_plot <- reactive({
    create_convergence_plot(fit_model$fit,pars=input$convPars)
  })
  output$plotConv <- renderPlot({
    convergence_plot()
  })
  output$downloadConv <- download_plot_img(
    p=convergence_plot, fname="convergence-plot"
  )
  output$downloadConvCode <- download_plot_code("R/plot_convergence.R")
  
  observeEvent(input$copyConvCode,{
    copy_plot_code("R/plot_convergence.R", session)
  })
  # Allow user to screenshot the current page of the App
  observeEvent(input$ssConv,{screenshot()})
    
  #
  # Posterior plot
  #
  
  posterior_plot <- reactive({
    create_posterior_plot(fit_model, pars=input$postPars)
  })
  output$plotPost <- renderPlot({
    posterior_plot()
  })
  output$downloadPost <- download_plot_img(
    posterior_plot, "posterior-plot"
  )
  observeEvent(input$copyPostCode,{
    copy_plot_code("R/plot_posterior_check.R", session)
  })
  output$downloadPostCode <- download_plot_code("R/plot_posterior_check.R")
  observeEvent(input$ssPost,{screenshot()})
}

# Run the application 
  shinyApp(ui = ui, server = server)
}
