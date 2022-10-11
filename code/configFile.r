setwd(here::here())

base_path <- here::here()
models_path <- file.path(base_path, "code/models/")
builders_path <- file.path(base_path, "code/builders/")
exec_path <- file.path(base_path, "code/Exec/")


# Paths
# ===
seed <- 1993
cesga <- TRUE

# Arguments
# ===
ExperimentName <- "antiTNF"
inputDir <- "/mnt/netapp2/Store_uni/home/ulc/co/jlb/git/run_mlr3/data/antiTNF/"
outDir <- "/mnt/netapp2/Store_uni/home/ulc/co/jlb/git/run_mlr3/results/"
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
method <- "exhaustive_search"
nevals <- 100
measure <- "classif.acc"

# Cesga arguments
# ===
part <- "medium"
time <- "10:00:00"
mem <- "120GB"
nodes <- 1
ntasks <- 24
