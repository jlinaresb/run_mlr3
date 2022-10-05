# Glmnet function
# =======
require(mlr3)
require(mlr3fselect)
require(mlr3tuning)
require(mlr3learners)
require(mlr3filters)
require(mlr3pipelines)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
source('../paths.r')
source('../utils/build_learners.r')
source('../utils/tuners.r')

glmnet_pipeline = function(data, 
                           dataname,
                           target = 'target',
                           positive = '', 
                           removeConstant = F,
                           normalize = F,
                           filterFeatures = F,
                           outDir = F)
  {
  
  # Make task
  task = TaskClassif$new(backend = data,
                         target = target,
                         positive = positive)
  
  # Remove constant features
  if (removeConstant == T) {
    print("Removing constant features")
    rcf = po("removeconstants")
    task = rcf$train(list(task = task))$output
  }
  
  # Normalizing features
  if (normalize == T) {
    print("Normalizing features")
    nf = po("scale")
    task = nf$train(input = list(task))$output
  }
  
  # Filter features
  if (filterFeatures == T) {
    print("Filtering features")
    filter = po("filter", filter = flt("kruskal_test"), filter.frac = 0.3)
    task = filter$train(list(task = task))$output
  }
  
  # Learner 
  learner = glmnet()
  
  # Nested resampling
  rr = fselect_nested(
    method = "genetic_search",
    task = task,
    learner = learner,
    inner_resampling = rsmp("holdout"),
    outer_resampling = rsmp("cv", folds = 10),
    measure = msr("classif.ce"),
    term_evals = 100,
    batch_size = 20
  )
  
  saveRDS(rr, file = paste0(outDir, 'rsmp_glmnet_', dataname, '.rds'))
  
}



