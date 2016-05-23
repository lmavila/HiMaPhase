#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J exploreProgeny
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/exploreProgeny-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/exploreProgeny-stderr-%j.txt


R --no-save < profiling/exploreProgeny.R
#sbatch -p bigmemm --mem 10000  slurm-scripts/run-exploreProgeny.sh
