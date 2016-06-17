#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J LDSearchRaw
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/LDSearchRaw-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/LDSearchRaw-stderr-%j.txt


R --no-save < profiling/LDSearchRaw.R 
#sbatch -p bigmemm --mem 10000   slurm-scripts/run-LDSearchRaw.sh

