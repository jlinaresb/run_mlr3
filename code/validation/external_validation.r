require(dplyr)
require(pbapply)
setwd(here::here())
source("~/git/run_mlr3/code/utils/validation_utils.r")

res_dir <- "results/antiTNF_gsva/"
files <- list.files(res_dir)

res <- pblapply(files, function(i) {
  model <- readRDS(file.path(res_dir, i))
  rr <- model$result
  return(rr$score(measures = measures)[, c(2, 4, 7, 9:13)])
})
res <- data.table::rbindlist(res)
res2 <- res %>%
  group_by(task_id, learner_id) %>%
  summarise(across(everything(), list(mean)))


# Plot resample results
res_melt <- reshape2::melt(res,
                            measure.vars = c("Accuracy",
                                             "AUCROC",
                                             "PRAUC",
                                             "Sensitivity",
                                             "Specificity"))

require(ggplot2)
require(viridis)
msr <- "Sensitivity"
toPlot <- res_melt[which(res_melt$variable == msr), ]
ggplot(toPlot,
  aes(x = learner_id, y = value, color = learner_id)) +
  geom_violin(trim = TRUE) +
  geom_jitter(position = position_jitter(.5)) +
  scale_color_manual(values = viridis(4)) +
  facet_wrap(~task_id) +
  theme_bw() +
  theme(axis.text.x = element_blank()) +
  theme(legend.position = "top")


# Check model errors
i <- 6
model <- readRDS(file.path(res_dir, files[i]))
model$result$learners[[1]]$learner$

model$result$prediction()$score(measures = measures)
model$result$prediction()$confusion

# Predictions
preds <- model$result$predictions()[[2]]

# Pheno data
pheno_dir <- "~/git/arthritis-drugs/data/antiTNF/pheno/blood/"
pheno_files <- list.files(pheno_dir)
pheno <- lapply(pheno_files, function(x) {
                              readRDS(file.path(pheno_dir, x))
})
pheno <- data.table::rbindlist(pheno)

# Data
data <- readRDS("~/git/run_mlr3/data/antiTNF_gsva/cell_gsva_n28")


data_s <- data[preds$row_ids, ]
pheno_s <- pheno[match(rownames(data_s), pheno$id), ]

pheno_s$prediction <- preds$response
pheno_s$truth <- preds$truth
pheno_s$success <- ifelse(pheno_s$prediction == pheno_s$truth, "yes", "no")
stopifnot(pheno_s$response == pheno_s$truth)

table(pheno_s$cohort, pheno_s$success, pheno_s$response)
