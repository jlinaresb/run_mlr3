setwd(dirname(rstudioapi::getSourceEditorContext()$path))
source('configFile.r')
source('paths.r')

if (cesga == T) {
  exec = 'sbatch'
} else{
  exec = 'sh'
}

# Execute in parallel from Cesga
input.paths = dir(path = inputDir)
input.algs = dir(path = path.algs,
                 pattern = pattern)

for (i in 1:length(input.paths)) {
  for (j in 1:length(input.algs)) {
    
    sink(paste0(
      exec_path, 
      gsub('.r', '', input.algs[j], fixed = T),
      gsub('.rds', '.sh', input.paths[i])))
    
    cat("#!/bin/bash \n")
    
    cat(paste("#SBATCH", "-p", part, '\n'))
    cat(paste("#SBATCH", "-t", time, '\n'))
    cat(paste("#SBATCH", paste0("--mem=",mem),'\n'))
    cat(paste("#SBATCH", "-N", nodes, '\n'))
    cat(paste("#SBATCH", "-n", ntasks, '\n'))    
    
    cat(paste("name=", input.paths[i], '\n', sep = ''))
    cat(paste("data=", input.dir.path, input.paths[i], '\n', sep = ''))
    cat(paste('Rscript ', models_path, input.algs[j], " $data", " $name", sep=''))
    
    sink(file = NULL)
    
    # system(paste(exec, " ", 
    #              exec_path, 
    #              gsub('.r', '', input.algs[j], fixed = T),
    #              gsub('.rds', '.sh', input.paths[i])))
  } 
}
