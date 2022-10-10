# RandomForest function
# =======
setwd(here::here())
source("code/configFile.r")
source("code/utils/build_learners.r")
source("code/utils/tuners.r")

rf_pipeline <- function(data,
                        dataname,
                        target,
                        positive,
                        removeConstant,
                        normalize,
                        filterFeatures,
                        outDir){

  data <- as.data.frame(data)
  data[, target] <- as.factor(data[, target])
  # Make task
  task <- TaskClassif$new(id = dataname,
                          backend = data,
                          target = target,
                          positive = positive)
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
    filter <- po("filter", filter = flt("kruskal_test"), filter.frac = 0.3)
    task <- filter$train(list(task = task))$output
  }
  # Learner
  learner <- randomForest()
  # Nested resampling
  rr <- fselect_nested(
    method = "genetic_search",
    task = task,
    learner = learner,
    inner_resampling = rsmp("holdout"),
    outer_resampling = rsmp("cv", folds = 10),
    measure = msr("classif.ce"),
    term_evals = 100
  )
  saveRDS(rr, file = paste0(outDir, "rsmp_rf_", dataname, ".rds"))
}