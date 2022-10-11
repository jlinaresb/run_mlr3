require(mlr3)
require(mlr3measures)

# Measures
measures <- list(msr("classif.acc", id = "Accuracy"),
                 msr("classif.auc", id = "AUCROC"),
                 msr("classif.prauc", id = "PRAUC"),
                 msr("classif.sensitivity", id = "Sensitivity"),
                 msr("classif.specificity", id = "Specificity"))


# Extract models
get_models <- function(model_path) {

    # Load model and task
    model <- readRDS(model_path)
    rr <- model$result
    task <- model$task

    # Number of folds
    k <- length(rr$predictions())

    # Get performances by fold
    sapply(1:k, function(x) rr$predictions()[[x]]$score(measures))

    # Extract the model of each fold
    final_models <- list()
    for (i in seq_along(1:k)) {
    features <- rr$learners[[i]]$fselect_result$features[[1]]
    new_task <- task$clone()
    new_task$select(features)
    final_models[[i]] <- rr$learners[[i]]$learner$model$learner$train(new_task)
    }
    return(final_models)
}