require(dplyr)
require(pbapply)
setwd(here::here())
source("~/git/run_mlr3/code/utils/validation_utils.r")

res_dir <- "~/git/arthritis-drugs/02_training/results/antiTNF_gsva/"
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


model <- readRDS(file.path(res_dir, files[i]))
print(files[i])

# =================
# See aggregate performances
rr <- model$result
rr$score(measures = measures)[, c(2, 4, 7, 9:13)]

# see performances by fold
preds <- rr$predictions()
lapply(preds, function(x) list(x$confusion))



# HASTA AQUÍ!
# TODO:
# - Hacer función para formatear los datos externos
# - Hacer el predict por fold
# - algún plot?
metacohort = readRDS("~/git/arthritis-drugs/data/antiTNF/metacohort/metacohort.rds")
metacohort = metacohort[, -c(1:8)]

table(metacohort$cohort)
gse1 = metacohort[which(metacohort$cohort == "GSE12051"), ]
gse2 = metacohort[which(metacohort$cohort == "GSE15258"), ]
gse3 = metacohort[which(metacohort$cohort == "GSE33377"), ]
gse4 = metacohort[which(metacohort$cohort == "GSE42296"), ]
gse5 = metacohort[which(metacohort$cohort == "GSE58795"), ]
all = rbind.data.frame(gse1, gse2, gse3, gse4, gse5)
gse = list(GSE12051 = gse1, 
           GSE15258 = gse2, 
           GSE33377 = gse3, 
           GSE42296 = gse4, 
           GSE58795 = gse5)


source('~/git/run_mlr3/code/utils/pipeline_utils.r')
ext_task1 = making_task(data = subset(gse[[1]], select = -cohort), dataname = names(gse)[1], target = "response", positive = "responder")
ext_task2 = making_task(data = subset(gse[[2]], select = -cohort), dataname = names(gse)[2], target = "response", positive = "responder")
ext_task3 = making_task(data = subset(gse[[3]], select = -cohort), dataname = names(gse)[3], target = "response", positive = "responder")
ext_task4 = making_task(data = subset(gse[[4]], select = -cohort), dataname = names(gse)[4], target = "response", positive = "responder")
ext_task_all = making_task(data = subset(all, select = -cohort), dataname = "all", target = "response", positive = "responder")

ext_task1 = preprocess(ext_task1, normalize = T, removeConstant = F, filterFeatures = F)
ext_task2 = preprocess(ext_task2, normalize = T, removeConstant = F, filterFeatures = F)
ext_task3 = preprocess(ext_task3, normalize = T, removeConstant = F, filterFeatures = F)
ext_task4 = preprocess(ext_task4, normalize = T, removeConstant = F, filterFeatures = F)
ext_task_all = preprocess(ext_task_all, normalize = T, removeConstant = F, filterFeatures = F)

ext_task = list(ext_task1,
                ext_task2,
                ext_task3,
                ext_task4)

for (i in seq_along(ext_task)) {
  print(sapply(1:k, function(x) finalModels[[x]]$predict(ext_task_all)$score(measures)))
}




