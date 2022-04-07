#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=12:00:00   # walltime - you'll usually want more than this
#SBATCH --ntasks=8   # number of processor cores (i.e. tasks) - you'll usually want more than this
#SBATCH --nodes=1   # number of nodes - you'll usually want more than this
#SBATCH -C 'avx2'
#SBATCH --mem-per-cpu=200M   # memory per CPU core

module purge
module load intel-compilers/2019 intel-mpi/2019 libfabric/1.8

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
OUTFILE=""

srun ./lmp_mpi < gb_run_900K.in

