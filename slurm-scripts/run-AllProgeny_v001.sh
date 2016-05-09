#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J AllProgeny
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/AllProgeny_v001-stdout-%j.txt
#SBATCH -e /home/lavila/projects/HiMaPhase/slurm-log/AllProgeny_v001-stderr-%j.txt


R --no-save < profiling/AllProgeny-v0.0.1.R
#sbatch -p bigmemm --mem 10000   slurm-scripts/run-AllProgeny_v001.sh

