#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J RawProgeny
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/RawProgeny-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/RawProgeny-stderr-%j.txt


R --no-save < profiling/RawProgeny.R
#sbatch -p bigmemm --mem 10000   slurm-scripts/run-RawProgeny.sh

