#!/bin/bash -l
#SBATCH -D /home/lavila/projects/test_project
#SBATCH -J OneRun
#SBATCH -o /home/lavila/projects/test_project/slurm-log/OneRun-stdout-%j.txt
#SBATCH -e /home/lavila/projects/test_project/slurm-log/OneRun-stderr-%j.txt


R --no-save < profiling/OneRun.R
#sbatch -p bigmemm --mem 160000 --ntasks=20 slurm-scripts/run-OneRun.sh
