# Paths
# ===
cesga <- FALSE

if (cesga == TRUE) {
  base_path <- "/mnt/netapp2/Store_uni/home/ulc/co/jlb/git/run_mlr3/"
} else {
  base_path <- "~/git/run_mlr3/"
}

models_path <- paste0(base_path, "code/models/")
builders_path <- paste0(base_path, "code/builders/")
exec_path <- paste0(base_path, "code/Exec/")
config_file_path <- paste0(base_path, "code/configFile.r")


seed <- 1993

# Arguments
# ===
ExperimentName <- "example"
inputDir <- "~/tmp/example_mlr3/data/"
outDir <- "~/tmp/example_mlr3/results/"
path.algs <- models_path
pattern <- ".r"

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
