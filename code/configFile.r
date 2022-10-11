setwd(here::here())

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
ExperimentName <- "cells_antiTNF"
inputDir <- "~/git/run_mlr3/data/antiTNF/"
outDir <- "~/git/run_mlr3/results/"
outDir <- file.path(outDir, ExperimentName)
if (dir.exists(outDir) == FALSE) {
    message(paste("Creating", ExperimentName, "directory!"))
    dir.create(outDir)
}

# Algorithms
# ===
path_algs <- models_path
pattern <- "xgboost.r"

# Input data characteristics
# ===
target <- "response"
positive <- "responder"

# Data preprocessing
# ===
removeConstant <- TRUE
normalize <- TRUE
filterFeatures <- TRUE

# Nested resampling
# ===
method <- "exhaustive_search"
nevals <- 10
measure <- "classif.ce"

# Cesga arguments
# ===
part <- "medium"
time <- "10:00:00"
mem <- "120GB"
nodes <- 1
ntasks <- 24
