#' Download the current plot as a PDF file
#'
#' @param p 
#' @param fname 
#'
#' @returns A download handler for the plot PDF
#' @export
#'
#' @examples

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

#' Download the R code as .R file used to generate the current plot
#'
#' @param file The path to the R script file
#'
#' @returns A download handler (Button) for the specified file
#' @export
#'
#' @examples
#' 
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
