#' Validate R-hat Threshold Parameter
#'
#' Validates that rhat_threshold is a positive numeric value greater than or
#' equal to 1
#'
#' @param rhat_threshold The R-hat convergence threshold
#'
#' @noRd
#' @srrstats {G5.2a} every error statement is unique
#'
#' @return NULL (invisibly) if validation passes, otherwise stops with error
validate_rhat_threshold <- function(rhat_threshold) {
  if (!is.numeric(rhat_threshold)) {
    cli::cli_abort("{.arg rhat_threshold} must be numeric, got {.cls
                   {class(rhat_threshold)}}")
  }
  
  if (length(rhat_threshold) != 1) {
    cli::cli_abort("{.arg rhat_threshold} must be a single value, got length
                   {length(rhat_threshold)}")
  }
  
  if (!is.finite(rhat_threshold)) {
    cli::cli_abort("{.arg rhat_threshold} must be a finite number")
  }
  
  if (rhat_threshold < 1.0) {
    cli::cli_abort(c(
      "{.arg rhat_threshold} must be greater than or equal to 1.0",
      "x" = "R-hat values are always >= 1 by definition",
      "i" = "Common thresholds: 1.01 (strict), 1.05 (moderate), 1.1 (lenient)"
    ))
  }
  
  # Warn if threshold seems unusual
  if (rhat_threshold > 2.0) {
    cli::cli_warn(c(
      "{.arg rhat_threshold} = {rhat_threshold} is unusually high",
      "i" = "This may not detect convergence issues effectively",
      "i" = "Consider using a value between 1.01 and 1.1"
    ))
  }
  
  invisible(NULL)
}

#' Validate Effective Sample Size Threshold Parameter
#'
#' Validates that eff_sample_threshold is a positive numeric value
#'
#' @param eff_sample_threshold The minimum effective sample size threshold
#'
#' @noRd
#' @srrstats {G5.2a} every error statement is unique
#'
#' @return NULL (invisibly) if validation passes, otherwise stops with error
validate_eff_sample_threshold <- function(eff_sample_threshold) {
  if (!is.numeric(eff_sample_threshold)) {
    cli::cli_abort("{.arg eff_sample_threshold} must be numeric, got {.cls
                   {class(eff_sample_threshold)}}")
  }
  
  if (length(eff_sample_threshold) != 1) {
    cli::cli_abort("{.arg eff_sample_threshold} must be a single value, got
                   length {length(eff_sample_threshold)}")
  }
  
  if (!is.finite(eff_sample_threshold)) {
    cli::cli_abort("{.arg eff_sample_threshold} must be a finite number")
  }
  
  if (eff_sample_threshold <= 0) {
    cli::cli_abort(c(
      "{.arg eff_sample_threshold} must be positive, got
      {eff_sample_threshold}",
      "i" = "Effective sample size represents the number of independent
      samples",
      "i" = "Common thresholds: 100 (minimum), 400 (good), 1000 (excellent)"
    ))
  }
  
  # Warn if threshold seems unusual
  if (eff_sample_threshold < 50) {
    cli::cli_warn(c(
      "{.arg eff_sample_threshold} = {eff_sample_threshold} is very low",
      "!" = "This may accept poorly sampled parameters",
      "i" = "Consider using a value of at least 100"
    ))
  }
  
  if (eff_sample_threshold > 5000) {
    cli::cli_warn(c(
      "{.arg eff_sample_threshold} = {eff_sample_threshold} is very high",
      "!" = "This threshold may be difficult to achieve",
      "i" = "Consider using a value between 100 and 1000"
    ))
  }
  
  invisible(NULL)
}

#' Validate object class inheritance
#'
#' Validates that an object inherits from one or more specified classes.
#' For multiple classes, the object must inherit from ALL specified classes.
#'
#' @param obj The object to validate
#' @param class_names Character vector of one or more class names to check
#' @param require_all Logical; if TRUE (default), object must inherit from ALL
#'   specified classes. If FALSE, object must inherit from at least ONE class.
#'
#' @noRd
#' @srrstats {G5.2a} every error statement is unique
#' @srrstats {G5.8, G5.8a} checks for zero length
#'
#' @return Invisible NULL if validation passes, otherwise throws an error
validate_class_inherits <- function(obj, class_names, require_all = TRUE) {
  
  # Ensure class_names is a character vector
  if (length(class_names) == 0) {
    cli::cli_abort("{class_names} must be a non-empty character vector")
  }
  
  # Check inheritance for each class
  inheritance_results <- vapply(class_names, function(cls) inherits(obj, cls),
                                FUN.VALUE = logical(1))
  
  obj_class <- class(obj)
  
  if (require_all) {
    # Must inherit from ALL classes
    if (!all(inheritance_results)) {
      missing_classes <- class_names[!inheritance_results]
      if (length(class_names) == 1) {
        cli::cli_abort("Input must be of class {class_names} but got class:
                       {obj_class}")
      } else {
        cli::cli_abort(c("Input must inherit from all classes: {class_names}",
                         "Missing classes: {missing_classes}",
                         "Actual classes: {obj_class}"))
      }
    }
  } else {
    # Must inherit from at least ONE class
    if (!any(inheritance_results)) {
      cli::cli_abort(c("Input must inherit from at least one of: {class_names}",
                       "Actual classes: {obj_class}"))
    }
  }
  
  invisible(NULL)
}