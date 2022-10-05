setwd(dirname(rstudioapi::getSourceEditorContext()$path))
source('configFile.r')

if (cesga == T) {
  basepath = "/mnt/netapp2/Store_uni/home/ulc/co/jlb/git/run_mlr3/"
} else{
  base_path = '~/git/run_mlr3/'
}

models_path = paste0(base_path, 'models/')
builders_path = paste0(base_path, 'builders/')
exec_path = paste0(base_path, 'Exec/')