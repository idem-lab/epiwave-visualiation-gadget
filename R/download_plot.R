# 
# A function to download the plot image as .pdf default
#
 
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

# Future dev: create number tags for duplicated downloads
# Currently only changes the system date

