#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J CheckImputed
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/CheckImputed-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/CheckImputed-stderr-%j.txt


R --no-save < profiling/CheckImputed.R 
#sbatch -p bigmemm --mem 10000   slurm-scripts/run-CheckImputed.sh

