# Predict with resample results
setwd(here::here())
source("code/utils/validation_utils.r")
options(warn = -1)

# Arguments
trainset <- "antiTNF_GSE129705_GSE15258"
res_dir <- file.path("results", trainset)

# See CV results
models_files <- list.files(res_dir, pattern = "glmnet")
models_files <- models_files[grep("gsvacells", models_files)]
m <- 1
res_cv <- list()
for (m in seq_along(models_files)) {
    model <- readRDS(file.path(res_dir, models_files[m]))
    rr <- model$result

    # See performance in outer CV (aggregate)
    thold <- 0.5
    threshold <- c("responder" = thold,
                "non-responder" = 1 - thold)
    pred <- rr$prediction()
    pred <- pred$set_threshold(threshold = threshold)
    pred$confusion
    pred <- pred$score(measures = measures)
    pred

    res_cv[[m]] <- data.frame(
        Accuracy = pred[1],
        AUCROC = pred[2],
        PRAUC = pred[3],
        Sensitivity = pred[4],
        Specificity = pred[5],
        trainset = trainset,
        algorithm = sapply(strsplit(models_files[m], "_"), "[", 2),
        score = sapply(strsplit(models_files[m], "_"), "[", 4))
}
res_cv <- rbindlist(res_cv)
View(res_cv)

saveRDS(res_cv, file = paste0("scores/cv_", trainset, ".rds"))

# Plotting
require(ggplot2)
require(ggpubr)
res_cv <- readRDS("~/git/run_mlr3/scores/cv_antiTNF_GSE129705.rds") 
res <- melt(res_cv)
ggscatter(data = res,
            x = "value", y = "score", color = "algorithm", facet.by = "variable")
