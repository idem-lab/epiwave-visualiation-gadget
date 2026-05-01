#
# A function to download raw code for each plot
#

download_plot_code <- function(file) {
  downloadHandler(
    filename=function() file,
    content=function(dest) file.copy(file,dest)
  )
}