setwd(here::here())
source("requirements.r")

base_path <- here::here()
models_path <- file.path(base_path, "code/models/")
builders_path <- file.path(base_path, "code/builders/")
exec_path <- file.path(base_path, "code/Exec/")


# Paths
# ===
seed <- 1993
cesga <- FALSE

# Arguments
# ===
ExperimentName <- "antiTNF"
inputDir <- file.path(base_path, "data/antiTNF/")
outDir <- file.path(base_path, "results/")
outDir <- file.path(outDir, ExperimentName)
if (dir.exists(outDir) == FALSE) {
    message(paste("Creating", ExperimentName, "directory!"))
    dir.create(outDir)
}

# Algorithms
# ===
path_algs <- models_path
pattern <- ".r"

# Input data characteristics
# ===
target <- "response"
positive <- "responder"

# Data preprocessing
# ===
removeConstant <- TRUE
normalize <- FALSE
filterFeatures <- FALSE

# Nested resampling
# ===
method <- "genetic_search"   #for autofselector
nevals <- 50                #for autofselector
measure <- "classif.acc"
outer <- rsmp("repeated_cv", repeats = 10, folds = 3)

# Cesga arguments
# ===
part <- "short"
time <- "06:00:00"
mem <- "64GB"
nodes <- 1
ntasks <- 24
