
# helper function that takes x as an input to return matrix data and predictor labels

prepare_x <- function(x) {

  x_mat <- as.matrix(x) # convert to matrix
  
  n_pred <- ncol(x_mat) # store the num of predictor
  pred_names <- colnames(x_mat)
  
  if (is.null(pred_names)) {
    pred_names <- paste0("x", 1:p) # x1, x2, x3
    colnames(x_mat) <- pred_names
  }
  
  list(
    x_mat=x_mat,
    n_pred=n_pred,
    pred_names=pred_names
  )
  
}