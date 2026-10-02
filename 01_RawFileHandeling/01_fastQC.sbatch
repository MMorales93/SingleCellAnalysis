#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=36
#SBATCH --time=02:00:00
#SBATCH --mem=120G
#SBATCH --partition=acpu
#SBATCH --mail-type=end
#SBATCH --mail-user=mamorale@colostate.edu
#SBATCH --output=log-fastqc-%j.out
#SBATCH --qos=cpu-normal

# Load Modules
module purge
module load fastqc multiqc

# FastQC
fastqc Input/Sample_FASTQs/Cawley_Jacob_SC_07212026/*.fastq.gz --outdir=Input/fastQC_Reports/

# Create combined graphs 
multiqc Input/fastQC_Reports/ -o Input/fastQC_Reports/
