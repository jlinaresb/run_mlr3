# RandomForest function
# =======
setwd(here::here())
source("code/configFile.r")
source("code/utils/build_learners.r")
source("code/utils/tuners.r")
source("code/utils/pipeline_utils.r")
source("requirements.r")


rf_pipeline <- function(data,
                        dataname,
                        target,
                        positive,
                        removeConstant,
                        normalize,
                        filterFeatures,
                        method,
                        measure,
                        nevals,
                        outDir) {
  # Make task
  task <- making_task(data,
                      dataname,
                      target,
                      positive)
  # Preprocess
  task <- preprocess(task,
                     removeConstant,
                     normalize,
                     filterFeatures)
  # Learner
  learner <- randomForest(measure, method, nevals)
  # Parallelization
  future::plan(list("multisession", "multisession"))
  # Resampling
  rr <- resample(task,
                 learner,
                 resampling = rsmp("cv", folds = 10),
                 store_models = TRUE)
  # Save resampling object
  res <- list(task = task,
              result = rr)
  saveRDS(res,
          file = paste0(outDir, "/rsmp_randomForest_", dataname, ".rds"))
}