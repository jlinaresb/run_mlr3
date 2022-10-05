setwd(dirname(rstudioapi::getSourceEditorContext()$path))
source('paths.r')

seed = 1993
cesga = T

# Paths
# ===
ExperimentName = 'example'
inputDir = '~/tmp/example_mlr3/data/'
outDir = '~/tmp/example_mlr3/results/'
path.algs = models_path
pattern = '.r'

# Input data characteristics
# ===
target = 'label'
positive = 'no'

# Data preprocessing
# ===
removeConstant = T
normalize = T
filterFeatures = T

# Cesga arguments
# ===
part = 'medium'
time = "10:00:00"
mem = "120GB"
nodes = 1
ntasks = 24
