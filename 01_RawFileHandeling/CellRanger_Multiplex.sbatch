#!/bin/bash

#SBATCH --partition=acpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=72:00:00
#SBATCH --mem=380G
#SBATCH --cpus-per-task=128
#SBATCH --array=1-4%4
#SBATCH --mail-type=end
#SBATCH --mail-user=mamorale@colostate.edu
#SBATCH --output=log-cellrangermulti-%A-%a.out
#SBATCH --qos=cpu-long

# Connect to Cell Ranger
export PATH=/projects/mamorale@colostate.edu/software/cellranger-10.0.0:$PATH

# Turn off warning about space
export MRO_DISK_SPACE_CHECK=disable

# Pull File Name
CONFIG_FILE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" /scratch/alpine/mamorale@colostate.edu/Spleen_CTO_SC/Input/ConfigList_2026-08-19.csv | awk -F, '{print $1}') 

# Pull ID Name
ID_NAME=$(sed -n "${SLURM_ARRAY_TASK_ID}p" /scratch/alpine/mamorale@colostate.edu/Spleen_CTO_SC/Input/ConfigList_2026-08-19.csv | awk -F, '{print $2}') 

#run from inside output folder
cellranger multi --id="${ID_NAME}" \
--csv="${CONFIG_FILE}" \
--jobmode=local \
--localcores=16 \
--localmem=360
