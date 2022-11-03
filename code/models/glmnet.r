setwd(here::here())
source("requirements.r")
source("code/configFile.r")
source("code/pipelines/glmnet_pipeline.r")

args <- commandArgs(trailingOnly = TRUE)

data <- readRDS(args[1])
names(data) <- make.names(names(data))
set.seed(seed)
progressr::handlers("progress")
glmnet_pipeline(
    data = data,
    dataname = args[2],
    target = target,
    positive = positive,
    removeConstant = removeConstant,
    normalize = normalize,
    filterFeatures = filterFeatures,
    inner = inner,
    outer = outer,
    measure = measure,
    method_at = method_at,
    method_afs = method_afs,
    term_evals = term_evals,
    fselector = fselector,
    workers = ntasks,
    outDir = outDir,
    parallel = parallel,
    resampling = resampling,
    folds = folds,
    batch_size = batch_size,
    seed = seed
)