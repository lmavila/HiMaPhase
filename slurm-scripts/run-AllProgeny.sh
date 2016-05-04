#!/bin/bash -l
#SBATCH -D /home/lavila/projects/HiMaPhase
#SBATCH -J AllProgeny
#SBATCH -o /home/lavila/projects/HiMaPhase/slurm-log/AllProgeny-stdout-%j.txt
#SBATCH -e /home/lavila/projects/test_project/HiMaPhase/AllProgeny-stderr-%j.txt


R --no-save < profiling/AllProgeny.R
#sbatch -p bigmemm --mem 160000 --ntasks=20 --time 30 slurm-scripts/run-AllProgeny.sh
