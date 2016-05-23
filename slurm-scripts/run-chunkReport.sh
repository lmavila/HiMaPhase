#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J chunkReport
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/chunkReport-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/chunkReport-stderr-%j.txt


R --no-save < profiling/chunkReport.R
#sbatch -p bigmemm --mem 10000  slurm-scripts/run-chunkReport.sh
