setwd(here::here())
source("code/configFile.r")

if (cesga == TRUE) {
  exec <- "sbatch"
} else {
  exec <- "sh"
}

# Execute in parallel from Cesga
files <- list.files(path = inputDir)
input_algs <- list.files(path = path_algs,
                 pattern = pattern)

for (i in seq_along(files)) {
  for (j in seq_along(input_algs)) {
    sink(paste0(
      exec_path,
      gsub(".r", "", input_algs[j], fixed = TRUE),
      "_",
      gsub(".rds", ".sh", files[i])))
    cat("#!/bin/bash \n")
    cat(paste("#SBATCH", "-p", part, "\n"))
    cat(paste("#SBATCH", "-t", time, "\n"))
    cat(paste("#SBATCH", paste0("--mem=", mem), "\n"))
    cat(paste("#SBATCH", "-N", nodes, "\n"))
    cat(paste("#SBATCH", "-n", ntasks, "\n"))
    cat(paste("name=", gsub(".rds", "", files[i]), "\n", sep = ""))
    cat(paste("data=", inputDir, files[i], "\n", sep = ""))
    cat(paste("Rscript ", models_path,
              input_algs[j], " $data", " $name", sep = ""))
    sink(file = NULL)
    system(paste(exec, " ",
                 exec_path,
                 gsub(".r", "", input_algs[j], fixed = TRUE),
                 gsub(".rds", ".sh", files[i])))
  }
}
