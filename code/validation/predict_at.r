# Predict with autotuner result
setwd(here::here())
source("code/utils/validation_utils.r")

# Arguments
res_dir <- "results/antiTNF_GSE129705/"
cohorts <- c("GSE12051", "GSE15258", "GSE33377", "GSE42296", "GSE58795")
test_pheno <- readRDS("data/antiTNF_GSE129705/test/test.rds")


# Prediction of all models in external validation
models_files <- list.files(res_dir)
for (m in seq_along(models_files)) {

    x <- models_files[m]
    print(paste0("Results of model: ", x))
    model <- readRDS(file.path(res_dir, x))

    # Trained learner
    l <- model$result

    # Extract features
    final_feats <- l$fselect_instance$result_feature_set

    # Predict by cohort
    for (i in seq_along(cohorts)) {
        c <- cohorts[i]
        test <- test_pheno[which(test_pheno$cohort == c),
                        match(c(final_feats, "response"),
                                colnames(test_pheno))]
        dim(test)
        # Prediction
        pred <- l$learner$model$learner$predict_newdata(test, task = NULL)
        print(pred$score(measures = measures))
    }
}