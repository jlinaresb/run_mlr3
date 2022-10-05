setwd(dirname(rstudioapi::getSourceEditorContext()$path))
source('../configFile.r')
source('../pipelines/glmnet_pipeline.r')

args = commandArgs(trailingOnly = T)

data = readRDS(args[1])
names(data) = make.names(names(data))
set.seed(seed)

glmnet_pipeline(data = data,
                dataname = args[2],
                target = 'target',
                positive = positive,
                removeConstant = removeConstant,
                normalize = normalize,
                filterFeatures = filterFeatures,
                outDir = outDir)