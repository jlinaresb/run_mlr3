# Random Forest
# ====
randomForest <- function() {
  tuner <- tnr("grid_search", resolution = 50)
  terminator <- trm("evals", n_evals = 50)
  # Inner
  inner <- rsmp("holdout", ratio = 0.7)
  # Make learner
  learner <- lrn("classif.randomForest", predict_type = "prob")
  measure <- msr("classif.acc")
  # Hyperparameter space
  ps <- ps(
    mtry = p_int(lower = 3, upper = 20),
    nodesize = p_int(lower = 2, upper = 5),
    ntree = p_int(300L)
  )
  # Autotuner
  at <- AutoTuner$new(learner = learner,
                     resampling = inner,
                     measure = measure,
                     terminator = terminator,
                     tuner = tuner,
                     search_space = ps,
                     store_tuning_instance = FALSE,
                     store_benchmark_result = FALSE,
                     store_models = FALSE)
  return(at)
}


# Glmnet
# ===
glmnet <- function() {
  tuner <- tnr("grid_search", resolution = 50)
  terminator <- trm("evals", n_evals = 50)
  # Innter
  inner <- rsmp("holdout", ratio = 0.7)
  # Make learner
  learner <- lrn("classif.glmnet", predict_type = "prob")
  learner$encapsulate <- c(train = "evaluate", predict = "evaluate")
  learner$fallback <- lrn("classif.log_reg", predict_type = "prob")
  # Establishing measure
  measure = msr("classif.acc")
  # Hyperparameter space
  ps <- ps(
    alpha = p_dbl(lower = 0, upper = 1),
    s = p_dbl(lower = 0, upper = 1)
  )
  # Autotuner
  at <- AutoTuner$new(learner = learner,
                     resampling = inner,
                     measure = measure,
                     terminator = terminator,
                     tuner = tuner,
                     search_space = ps,
                     store_tuning_instance = FALSE,
                     store_benchmark_result = FALSE,
                     store_models = FALSE)
  return(at)
}



# XGBoost
xgboost = function(){
  
  tuner = tnr("grid_search", resolution = 50)
  terminator = trm("evals", n_evals = 50)
  
  inner = rsmp("holdout", ratio = 0.7)
  
  learner = lrn("classif.xgboost", predict_type = "prob")
  measure = msr("classif.acc")
  
  ps = ps(
    booster = p_fct(levels = c("gbtree", "gblinear", "dart")),
    alpha = p_dbl(lower = 0, upper = 1),
    eta = p_dbl(lower = 0, upper = 1),
    lambda = p_dbl(lower = 0.2, upper = 0.8),
    gamma = p_dbl(lower = 0.2, upper = 0.8)
  )
  
  at = AutoTuner$new(learner = learner,
                     resampling = inner,
                     measure = measure,
                     terminator = terminator,
                     tuner = tuner,
                     search_space = ps,
                     store_tuning_instance = FALSE,
                     store_benchmark_result = FALSE,
                     store_models = FALSE)
  
  return(at)
}

