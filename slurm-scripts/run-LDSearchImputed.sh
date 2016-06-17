#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J LDSearchImputed
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/LDSearchImputed-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/LDSearchImputed-stderr-%j.txt


R --no-save < profiling/LDSearchImputed.R 
#sbatch -p bigmemm --mem 10000   slurm-scripts/run-LDSearchImputed.sh

