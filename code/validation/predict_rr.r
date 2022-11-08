# Predict with resample results
setwd(here::here())
source("code/utils/validation_utils.r")
options(warn = -1)

# Arguments
res_dir <- "results/antiTNF_GSE15258/"
cohorts <- c("GSE129705", "GSE12051",
             "GSE15258", "GSE33377",
             "GSE42296", "GSE58795")
test_pheno <- readRDS("data/antiTNF_GSE129705/test/test.rds")

# See CV results
models_files <- list.files(res_dir)

m <- 1
model <- readRDS(file.path(res_dir, models_files[m]))
rr <- model$result

# See performance in outer CV (aggregate)
rr$prediction()$score(measures)
rr$prediction()$confusion

# External validation
iters <- 1:rr$iters
ext_preds <- lapply(iters, function(k) {

    # Trained learner
    l <- model$result$learners[[k]]

    # Extract features
    final_feats <- l$fselect_instance$result_feature_set

    # Predict by cohort
    res <- list()
    for (i in seq_along(cohorts)) {
        c <- cohorts[i]
        test <- test_pheno[which(test_pheno$cohort == c),
                        match(c(final_feats, "response"),
                                colnames(test_pheno))]
        dim(test)
        # Prediction
        pred <- l$learner$model$learner$predict_newdata(test, task = NULL)
        pred_m <- pred$score(measures = measures)
        res[[i]] <- data.frame(
            Accuracy = pred_m[1],
            AUCROC = pred_m[2],
            PRAUC = pred_m[3],
            Sensitivity = pred_m[4],
            Specificity = pred_m[5],
            cohort = c,
            row.names = i
        )
    }
    iteration <- rbindlist(res)
    iteration$fold <- k
    return(iteration)
})


validation <- rbindlist(ext_preds)
validation$algorithm <- sapply(strsplit(models_files[m], "_"), "[", 2)
View(validation)
