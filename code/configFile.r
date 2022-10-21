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

ExperimentName <- "antiTNF_all"
inputDir <- file.path(base_path, "data/antiTNF_all/")
outDir <- file.path(base_path, "results/")
outDir <- file.path(outDir, ExperimentName)
if (dir.exists(outDir) == FALSE) {
    message(paste("Creating", ExperimentName, "directory!"))
    dir.create(outDir)
}

# Algorithms
path_algs <- models_path
pattern <- "lgbm.r"

# Input data characteristics
target <- "response"
positive <- "responder"

# Data preprocessing
removeConstant <- TRUE
normalize <- FALSE
filterFeatures <- FALSE

# Parallelization
parallel <- TRUE
batch_size <- 10
folds <- 10

# Tuning
fselector <- FALSE
measure <- msr("classif.acc")
method_at <- tnr("grid_search", resolution = 10, batch_size = batch_size)
method_afs <- "sequential"
inner <- rsmp("holdout", ratio = 0.7)
outer <- rsmp("cv", folds = folds)
term_evals <- NULL



# Cesga arguments
# ===
part <- "short"
time <- "02:00:00"
mem <- "120GB"
nodes <- 1
ntasks <- 20
