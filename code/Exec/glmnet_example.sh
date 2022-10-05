#!/bin/bash 
#SBATCH -p medium 
#SBATCH -t 10:00:00 
#SBATCH --mem=120GB 
#SBATCH -N 1 
#SBATCH -n 24 
name=example
data=/home/joselinares/tmp/example_mlr3/data//example.rds
Rscript /home/joselinares/git/run_mlr3/code/models/glmnet.r $data $name