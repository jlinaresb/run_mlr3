setwd(here::here())
source("configFile.r")

if (cesga == TRUE) {
  base_path <- "/mnt/netapp2/Store_uni/home/ulc/co/jlb/git/run_mlr3/"
} else {
  base_path <- "~/git/run_mlr3/"
}

models_path <- paste0(base_path, "code/models/")
builders_path <- paste0(base_path, "code/builders/")
exec_path <- paste0(base_path, "code/Exec/")