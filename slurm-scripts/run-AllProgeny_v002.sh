#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J AllProgeny_v002
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/AllProgeny_v002-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/AllProgeny_v002-stderr-%j.txt


R --no-save < profiling/AllProgeny-v0.0.2.R
#sbatch -p bigmemm --mem 10000   slurm-scripts/run-AllProgeny_v002.sh

