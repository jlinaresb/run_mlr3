setwd(here::here())
source("requirements.r")

base_path <- here::here()
models_path <- file.path(base_path, "code/models/")
builders_path <- file.path(base_path, "code/builders/")
exec_path <- file.path(base_path, "code/Exec/")


# Arguments
# ===
seed <- 1993
cesga <- TRUE

<<<<<<< HEAD
ExperimentName <- "clinical_preciseads"
inputDir <- file.path(base_path, "data/precisead")
=======
ExperimentName <- "antiTNF_GSE129705_GSE15258_no_moderates"
inputDir <- file.path(base_path, "data/antiTNF_v2")
>>>>>>> 1bef043ec1cc8c31f5744e34ff81ce075b7dc16f
outDir <- file.path(base_path, "results/")
outDir <- file.path(outDir, ExperimentName)
if (dir.exists(outDir) == FALSE) {
    message(paste("Creating", ExperimentName, "directory!"))
    dir.create(outDir)
}

# Algorithms
path_algs <- models_path
pattern <- ".r"

# Input data characteristics
target <- "Clusters"
positive <- "cluster_1"

# Data preprocessing
removeConstant <- TRUE
normalize <- TRUE
filterFeatures <- FALSE

# Pipeline
resampling <- TRUE

# Parallelization
parallel <- TRUE
batch_size <- 10
folds <- 10  # no son folds! es para paralelizar el outer

# Tuning
fselector <- FALSE
measure <- msr("classif.acc")
method_at <- tnr("grid_search", batch_size = batch_size)
method_afs <- "random_search"
inner <- rsmp("holdout", ratio = 0.8)
outer <- rsmp("cv", folds = 10)
term_evals <- 10000
n_evals_afs <- 500


# Cesga arguments
# ===
part <- "short"
time <- "06:00:00"
mem <- "120GB"
nodes <- 1
ntasks <- 24
