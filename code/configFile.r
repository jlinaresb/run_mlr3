setwd(here::here())
source("requirements.r")

base_path <- here::here()
models_path <- file.path(base_path, "code/models/")
builders_path <- file.path(base_path, "code/builders/")
exec_path <- file.path(base_path, "code/Exec/")


# Arguments
# ===
seed <- 1993
cesga <- FALSE

ExperimentName <- "antiTNF"
inputDir <- file.path(base_path, "data/antiTNF/")
outDir <- file.path(base_path, "results/")
outDir <- file.path(outDir, ExperimentName)
if (dir.exists(outDir) == FALSE) {
    message(paste("Creating", ExperimentName, "directory!"))
    dir.create(outDir)
}

# Algorithms
path_algs <- models_path
pattern <- "glmnet.r"

# Input data characteristics
target <- "response"
positive <- "responder"

# Data preprocessing
removeConstant <- TRUE
normalize <- FALSE
filterFeatures <- FALSE

# Tuning
measure <- msr("classif.acc")
method_at <- "grid_search"
method_afs <- "genetic_search"
inner <- rsmp("holdout", ratio = 0.7)
outer <- rsmp("repeated_cv", repeats = 10, folds = 3)
term_evals <- 5


# Cesga arguments
# ===
part <- "short"
time <- "06:00:00"
mem <- "64GB"
nodes <- 1
ntasks <- 24
