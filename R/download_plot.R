#' Download the current plot as a PDF file
#'
#' @param p A reactive/function that returns the plot to render.
#' @param fname Base file name (date and ".pdf" are appended).
#'
#' @returns A download handler for the plot PDF
#' @export
#'
#' @examples
#'output$downloadPriorParam <- download_plot_img(p=prior_param_plot, fname="prior-param-plot")
download_plot_img <- function(p, fname) {
  downloadHandler(
    filename = function () {
      paste0(fname, "-" , Sys.Date(), ".pdf")
    },
    content = function(file) {
      pdf(file)
      out <- p() # plot function
      print(out)
      dev.off()
    }
  )
}

#' Download the R code used to generate the current plot
#'
#' @param template_path Path to the template R script.
#' @param pars_input Reactive/function returning the parameter values to insert.
#' @param pars_placeholder Line in the template to replace with parameters.
#' @param call_placeholder Line in the template to replace with the function call.
#' @param pars_replacement Glue string used to build the parameter replacement.
#' @param call_replacement Glue string used to build the call replacement.
#'
#' @returns A download handler (Button) for the specified file
#' @export
#'
#' @examples
#' output$downloadPriorParamCode <- download_plot_code("R/plot_prior_check.R")
download_plot_code <- function(template_path, pars_input,
                               pars_placeholder  = "# __PARS__",
                               call_placeholder  = "# __CALL__",
                               pars_replacement,
                               call_replacement) {
  downloadHandler(
    filename = function() basename(template_path),
    content  = function(file) {
      pars_string <- paste(shQuote(pars_input()), collapse = ", ")
      code <- readLines(template_path)
      code <- gsub(paste0(".*", pars_placeholder), glue::glue(pars_replacement), code)
      code <- gsub(paste0(".*", call_placeholder), glue::glue(call_replacement), code)
      writeLines(code, file)
    }
  )
}
