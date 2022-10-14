# Random Forest
# ====
randomForest <- function(measure, method, nevals) {
  tuner <- tnr("grid_search", resolution = 50)
  terminator <- trm("evals", n_evals = 50)
  # Inner
  inner <- rsmp("holdout", ratio = 0.7)
  # Make learner
  learner <- lrn("classif.randomForest", predict_type = "prob")
  # Establishing Measure
  measure <- msr(measure)
  # Hyperparameter space
  ps <- ps(
    mtry = p_int(lower = 3, upper = 8),
    nodesize = p_int(lower = 2, upper = 5),
    ntree = p_int(lower = 500, upper = 1000)
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
  # Autotuner features
  afs <- auto_fselector(
    method = method,
    learner = at,
    resampling = inner,
    measure = measure,
    term_evals = nevals
  )
  return(afs)
}


# Glmnet
# ===
glmnet <- function(measure, method, nevals) {
  tuner <- tnr("grid_search", resolution = 50)
  terminator <- trm("evals", n_evals = 50)
  # Innter
  inner <- rsmp("holdout", ratio = 0.7)
  # Make learner
  learner <- lrn("classif.glmnet", predict_type = "prob")
  learner$encapsulate <- c(train = "evaluate", predict = "evaluate")
  learner$fallback <- lrn("classif.log_reg", predict_type = "prob")
  # Establishing measure
  measure <- msr(measure)
  # Hyperparameter space
  ps <- ps(
    alpha = p_dbl(lower = 0, upper = 1),
    s = p_dbl(lower = 0, upper = 1)
  )
  # Autotuner hyperparameters
  at <- AutoTuner$new(learner = learner,
                     resampling = inner,
                     measure = measure,
                     terminator = terminator,
                     tuner = tuner,
                     search_space = ps,
                     store_tuning_instance = FALSE,
                     store_benchmark_result = FALSE,
                     store_models = FALSE)
  # Autotuner features
   afs <- auto_fselector(
    method = method,
    learner = at,
    resampling = inner,
    measure = measure,
    term_evals = nevals
  )
  return(afs)
}


# SVM
# ===
svm <- function(measure, method, nevals) {
  tuner <- tnr("grid_search", resolution = 50)
  terminator <- trm("evals", n_evals = 50)
  # Inner
  inner <- rsmp("holdout", ratio = 0.7)
  # Make learner
  learner <- lrn("classif.svm", predict_type = "prob")
  # Establishing measure
  measure <- msr(measure)
  # Hyperparameter space
  ps <- ps(
    cost = p_dbl(lower = 1e-5, upper = 1e5, logscale = TRUE),
    gamma = p_dbl(lower = 1e-5, upper = 1e5, logscale = TRUE),
    kernel = p_fct(levels = c("polynomial", "radial", "sigmoid")),
    type = p_fct(levels = "C-classification")
  )
  # Autotuner hyperparameters
  at <- AutoTuner$new(learner = learner,
                     resampling = inner,
                     measure = measure,
                     terminator = terminator,
                     tuner = tuner,
                     search_space = ps,
                     store_tuning_instance = FALSE,
                     store_benchmark_result = FALSE,
                     store_models = FALSE)
  # Autotuner features
  afs <- auto_fselector(
    method = method,
    learner = at,
    resampling = inner,
    measure = measure,
    term_evals = nevals
  )
  return(afs)
}


# XGBoost
xgboost <- function(measure, method, nevals){
  tuner <- tnr("grid_search", resolution = 50)
  terminator <- trm("evals", n_evals = 50)
  # Inner
  inner <- rsmp("holdout", ratio = 0.7)
  # Make learner
  learner <- lrn("classif.xgboost", predict_type = "prob")
  # Establishing measure
  measure <- msr(measure)
  # Hyperparameter space
  ps <- ps(
    booster = p_fct(levels = c("gbtree", "gblinear", "dart")),
    alpha = p_dbl(lower = 0, upper = 1),
    eta = p_dbl(lower = 0, upper = 1),
    lambda = p_dbl(lower = 0.2, upper = 0.8),
    gamma = p_dbl(lower = 0.2, upper = 0.8)
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
  # Autotuner features
  afs <- auto_fselector(
    method = method,
    learner = at,
    resampling = inner,
    measure = measure,
    term_evals = nevals
    )
  return(afs)
}


# Ligth GBM
lgbm <- function(measure, method, nevals){
  tuner <- tnr("grid_search", resolution = 50)
  terminator <- trm("evals", n_evals = 50)
  # Inner
  inner <- rsmp("holdout", ratio = 0.7)
  # Make learner
  learner <- lrn("classif.lightgbm", predict_type = "prob")
  # Establishing measure
  measure <- msr(measure)
  # Hyperparameter space
  ps <- ps(
    learning_rate = p_dbl(lower = 0.01, upper = 0.3),
    num_leaves = p_int(lower = 50, upper = 100),
    max_depth = p_int(lower = 5, upper = 10),
    min_data_in_leaf = p_int(lower = 20, upper = 70)
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
  # Autotuner features
  afs <- auto_fselector(
    method = method,
    learner = at,
    resampling = inner,
    measure = measure,
    term_evals = nevals
    )
  return(afs)
}