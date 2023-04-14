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

ExperimentName <- "try5-binary"
inputDir <- "/mnt/netapp2/Store_uni/home/ulc/co/jlb/git/clinical_aid_clusters/04_clinical_model/toRun/try5-binary/"
outDir <- "/mnt/netapp2/Store_uni/home/ulc/co/jlb/git/clinical_aid_clusters/04_clinical_model/res"
outDir <- file.path(outDir, ExperimentName)
if (dir.exists(outDir) == FALSE) {
    message(paste("Creating", ExperimentName, "directory!"))
    dir.create(outDir)
}

# Algorithms
path_algs <- models_path
pattern <- ".r"

# Input data characteristics
target <- "clusters"
positive <- NULL

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
term_evals <- 50000
n_evals_afs <- 500


# Cesga arguments
# ===
part <- "short"
time <- "06:00:00"
mem <- "120GB"
nodes <- 1
ntasks <- 24
