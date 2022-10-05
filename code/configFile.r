setwd(here::here())

base_path <- here::here()
models_path <- file.path(base_path, "code/models/")
builders_path <- file.path(base_path, "code/builders/")
exec_path <- file.path(base_path, "code/Exec/")
file.remove(paste0(exec_path, list.files(exec_path)))


# Paths
# ===
cesga <- FALSE
seed <- 1993

# Arguments
# ===
ExperimentName <- "example"
inputDir <- "~/tmp/example_mlr3/data"
outDir <- "~/tmp/example_mlr3/results"
path_algs <- models_path
pattern <- ".r"

outDir <- file.path(outDir, ExperimentName)
if (dir.exists(outDir) == FALSE) {
    message(paste("Creating", ExperimentName, "directory!"))
    dir.create(outDir)
}


# Input data characteristics
# ===
target <- "label"
positive <- "no"

# Data preprocessing
# ===
removeConstant <- TRUE
normalize <- TRUE
filterFeatures <- TRUE

# Cesga arguments
# ===
part <- "medium"
time <- "10:00:00"
mem <- "120GB"
nodes <- 1
ntasks <- 24
