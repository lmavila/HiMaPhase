#!/bin/bash -l
#SBATCH -D /home/lavila/projects/test_project
#SBATCH -J exploreProgeny
#SBATCH -o /home/lavila/projects/test_project/slurm-log/exploreProgeny-stdout-%j.txt
#SBATCH -e /home/lavila/projects/test_project/slurm-log/exploreProgeny-stderr-%j.txt


R --no-save < profiling/exploreProgeny.R
#sbatch -p bigmemh --mem 160000 --ntasks=20 slurm-scripts/run-exploreProgeny.sh
