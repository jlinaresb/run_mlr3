setwd(here::here())

base_path <- here::here()
models_path <- file.path(base_path, "code/models/")
builders_path <- file.path(base_path, "code/builders/")
exec_path <- file.path(base_path, "code/Exec/")


# Paths
# ===
seed <- 1993

# Arguments
# ===
ExperimentName <- "cells_antiTNF"
inputDir <- "~/git/run_mlr3/data/antiTNF/"
outDir <- "~/git/run_mlr3/results/"
path_algs <- models_path
pattern <- ".r"

# Input data characteristics
# ===
target <- "response"
positive <- "responder"

# Data preprocessing
# ===
removeConstant <- TRUE
normalize <- TRUE
filterFeatures <- FALSE

# Cesga arguments
# ===
part <- "medium"
time <- "10:00:00"
mem <- "120GB"
nodes <- 1
ntasks <- 24
