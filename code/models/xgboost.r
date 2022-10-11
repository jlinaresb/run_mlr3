setwd(here::here())
source("requirements.r")
source("code/configFile.r")
source("code/pipelines/xgboost_pipeline.r")

args <- commandArgs(trailingOnly = TRUE)

data <- readRDS(args[1])
names(data) <- make.names(names(data))
set.seed(seed)

xgboost_pipeline(data = data,
                dataname = args[2],
                target = target,
                positive = positive,
                removeConstant = removeConstant,
                normalize = normalize,
                filterFeatures = filterFeatures,
                method,
                measure,
                nevals,
                outDir = outDir)