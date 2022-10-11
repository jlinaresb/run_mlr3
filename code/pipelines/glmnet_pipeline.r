# Glmnet function
# =======
setwd(here::here())
source("code/configFile.r")
source("code/utils/build_learners.r")
source("code/utils/tuners.r")
source("code/utils/pipeline_utils.r")
source("requirements.r")

glmnet_pipeline <- function(data,
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
  learner <- glmnet()
  # Parallelization
  future::plan(list("sequential", "multisession"))
  # Nested resampling
  rr <- nested_resampling(task,
                          learner,
                          method,
                          nevals,
                          measure)
  # Save resampling object
  res <- list(task = task,
              result = rr)
  saveRDS(res,
          file = paste0(outDir, "/rsmp_glmnet_", dataname, ".rds"))
}