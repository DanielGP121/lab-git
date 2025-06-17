#!/bin/bash

#!/bin/bash
#SBATCH -p hpc-bio-pacioli
#SBATCH --chdir=/home/alumno09/lab-git
#SBATCH -J corte-fastq-alumno09
#SBATCH --output=corte-fastq-%j.out
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1

echo "--- INICIANDO TRABAJO DE CORTE PARALELO (v3) ---"
date

# Solo le decimos a srun que ejecute el script.
time srun ./file-cut.sh 

echo "--- TRABAJO FINALIZADO ---"
date