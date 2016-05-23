#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J exploreRawProgeny
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/exploreRawProgeny-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/exploreRawProgeny-stderr-%j.txt


R --no-save < profiling/exploreRawProgeny.R
#sbatch -p bigmemm --mem 10000  slurm-scripts/run-exploreRawProgeny.sh
