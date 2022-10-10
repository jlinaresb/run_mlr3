# SCRIPT INCOMPLETO!!!    

# Extract models
k = length(rr$predictions())

finalModels = list()
for (i in seq_along(1:k)) {
  features = rr$learners[[i]]$fselect_result$features[[1]]
  newTask = task$clone()
  newTask$select(features)
  
  finalModels[[i]] = rr$learners[[i]]$learner$model$learner$train(newTask)
}

# Example data
df = as.data.frame(matrix(rnorm(1000), ncol = 10))
df$label = sample(c("yes", "no"), nrow(df), replace = T)
saveRDS(df, file = '~/tmp/example_mlr3/data/example.rds')
