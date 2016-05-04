!/bin/bash -l
#SBATCH -D /home/USERNAME
#SBATCH -J bob
#SBATCH -o /home/USERNAME/out-%j.txt
#SBATCH -e /home/USERNAME/error-%j.txt
#SBATCH --array=1-9

bob=( 1 1 1 2 2 2 3 3 3 )
sue=( 1 2 3 1 2 3 1 2 3 )

block=${bob[$SLURM_ARRAY_TASK_ID]}
min=${sue[$SLURM_ARRAY_TASK_ID]}

echo "$block is $min" 
