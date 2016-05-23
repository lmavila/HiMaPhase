#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J Verbose
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/Verbose-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/Verbose-stderr-%j.txt


R --no-save < profiling/Verbose.R
#sbatch -p bigmemm --mem 10000   slurm-scripts/run-Verbose.sh

