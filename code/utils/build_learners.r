setwd(here::here())
source("code/utils/tuning_utils.r")

# Random Forest
# ====
randomForest <- function(inner,
                         measure,
                         method_at,
                         method_afs,
                         term_evals) {
  # Make learner
  learner <- lrn("classif.randomForest",
                  predict_type = "prob")
  # Hyperparameter space
  ps <- ps(
    mtry = p_int(lower = 3, upper = 15),
    nodesize = p_int(lower = 1, upper = 5),
    ntree = p_int(lower = 900, upper = 1000)
  )
  # Hyperparameters and features tuner
  afs <- make_tuner(inner,
                    measure,
                    learner,
                    ps,
                    term_evals,
                    method_at,
                    method_afs)
  return(afs)
}


# Glmnet
# ===
glmnet <- function(inner,
                   measure,
                   method_at,
                   method_afs,
                   term_evals) {
  # Make learner
  learner <- lrn("classif.glmnet",
                predict_type = "prob")
  learner$encapsulate <- c(train = "evaluate", predict = "evaluate")
  learner$fallback <- lrn("classif.log_reg", predict_type = "prob")
  # Hyperparameter space
  ps <- ps(
    alpha = p_dbl(lower = 0, upper = 1),
    s = p_dbl(lower = 0, upper = 1)
  )
  # Hyperparameters and features tuner
  afs <- make_tuner(inner,
                    measure,
                    learner,
                    ps,
                    term_evals,
                    method_at,
                    method_afs)
  return(afs)
}


# SVM
# ===
svm <- function(inner,
                measure,
                method_at,
                method_afs,
                term_evals) {
  # Make learner
  learner <- lrn("classif.svm",
                 predict_type = "prob")
  # Hyperparameter space
  ps <- ps(
    cost = p_dbl(lower = 1e-5, upper = 1e5, logscale = TRUE),
    gamma = p_dbl(lower = 1e-5, upper = 1e5, logscale = TRUE),
    kernel = p_fct(levels = c("polynomial", "radial", "sigmoid")),
    type = p_fct(levels = "C-classification")
  )
  # Hyperparameters and features tuner
  afs <- make_tuner(inner,
                    measure,
                    learner,
                    ps,
                    term_evals,
                    method_at,
                    method_afs)
  return(afs)
}


# XGBoost
xgboost <- function(inner,
                    measure,
                    method_at,
                    method_afs,
                    term_evals) {
  # Make learner
  learner <- lrn("classif.xgboost",
                 predict_type = "prob")
  # Hyperparameter space
  ps <- ps(
    booster = p_fct(levels = c("gbtree", "gblinear", "dart")),
    alpha = p_dbl(lower = 0, upper = 1),
    eta = p_dbl(lower = 0, upper = 1),
    lambda = p_dbl(lower = 0.2, upper = 0.8),
    gamma = p_dbl(lower = 0.2, upper = 0.8)
  )
  # Hyperparameters and features tuner
  afs <- make_tuner(inner,
                    measure,
                    learner,
                    ps,
                    term_evals,
                    method_at,
                    method_afs)
  return(afs)
}


# Ligth GBM
lgbm <- function(inner,
                 measure,
                 method_at,
                 method_afs,
                 term_evals) {
  # Make learner
  learner <- lrn("classif.lightgbm",
                 predict_type = "prob")
  # Hyperparameter space
  ps <- ps(
    learning_rate = p_dbl(lower = 0.01, upper = 0.3),
    num_leaves = p_int(lower = 50, upper = 100),
    max_depth = p_int(lower = 5, upper = 10),
    min_data_in_leaf = p_int(lower = 20, upper = 70)
  )
  # Hyperparameters and features tuner
  afs <- make_tuner(inner,
                    measure,
                    learner,
                    ps,
                    term_evals,
                    method_at,
                    method_afs)
  return(afs)
}