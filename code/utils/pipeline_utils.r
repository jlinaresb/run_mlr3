# Making task
making_task <- function(data, dataname, target, positive) {
    data <- as.data.frame(data)
    data[, target] <- as.factor(data[, target])
    # Make task
    task <- TaskClassif$new(id = dataname,
                        backend = data,
                        target = target,
                        positive = positive)
    return(task)
}

# Preprocess
preprocess <- function(task,
                       removeConstant,
                       normalize,
                       filterFeatures) {

  # Remove constant features
  if (removeConstant == TRUE) {
    print("Removing constant features")
    rcf <- po("removeconstants")
    task <- rcf$train(list(task = task))$output
  }
  # Normalizing features
  if (normalize == TRUE) {
    print("Normalizing features")
    nf <- po("scale")
    task <- nf$train(input = list(task))$output
  }
  # Filter features
  if (filterFeatures == TRUE) {
    print("Filtering features")
    filter <- po("filter",
                 filter = flt("kruskal_test"),
                 filter.frac = 0.01)
    task <- filter$train(list(task = task))$output
  }

  return(task)
}


# Nested resampling
nested_resampling <- function(task,
                              learner,
                              method,
                              nevals = 100,
                              measure = "classif.ce") {

    rr <- fselect_nested(
                method = method,
                task = task,
                learner = learner,
                inner_resampling = rsmp("holdout"),
                outer_resampling = rsmp("cv", folds = 10),
                measure = msr(measure),
                term_evals = nevals)

    return(rr)
}