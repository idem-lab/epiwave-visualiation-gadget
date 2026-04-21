map <- function(pred_names) {
  
  n_pred <- length(pred_names)
  df <- data.frame(
    raw_names = c("int",paste0("coef[1,", 1:p, "]"), "sd"), # intercept, coefficient/s, sd
    pred_type = c("intercept",rep("coef",p),"noise"),
    pred_name = c(NA, pred_names,NA),
    display_name = c("Intercept",paste("coef:",pred_names),"Noise")
  )
  df
}