#
# A function that copies the code of the plot to clipboard via JS
#

copy_plot_code <- function(file) {
  code <- paste(readLines(file),collapse="\n")
  session$sendCustomMessage("copy-code",code)
}