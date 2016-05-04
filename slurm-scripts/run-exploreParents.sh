#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J exploreParents
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/exploreParents-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/exploreParents-stderr-%j.txt


R --no-save < profiling/exploratory.R
#sbatch -p bigmemh --mem 160000 --ntasks=20 slurm-scripts/run-exploreParents.sh
