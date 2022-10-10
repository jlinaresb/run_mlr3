setwd(here::here())
source("requirements.r")
source("code/configFile.r")
source("code/pipelines/rf_pipeline.r")

args <- commandArgs(trailingOnly = TRUE)

data <- readRDS(args[1])
names(data) <- make.names(names(data))
set.seed(seed)

glmnet_pipeline(data = data,
                dataname = args[2],
                target = target,
                positive = positive,
                removeConstant = removeConstant,
                normalize = normalize,
                filterFeatures = filterFeatures,
                outDir = outDir)