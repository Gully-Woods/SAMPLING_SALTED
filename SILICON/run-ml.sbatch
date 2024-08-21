#!/bin/bash -l
# Standard output and error:
#SBATCH -o ./ML-Si.out
#SBATCH -e ./ML-setup.err
# Initial working directory:
##SBATCH -D ./
# Job Name:
#SBATCH -J ML-water
# Queue (Partition):
#SBATCH --partition=nodes
#SBATCH --nodes=1
#SBATCH --ntasks=20
# for OpenMP:
#SBATCH --cpus-per-task=1
#
# Memory usage of the job [MB], 3800 MB per task:
#SBATCH --mem-per-cpu=3800
#
#SBATCH --mail-type=none
#
# Wall clock limit:
#SBATCH --time=1:00:00

### SET UP ENVIRONMENT VARIABLES: (uncomment and edit as needed)

module purge

# Load modules
module load intel Python
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi2.so

ulimit -s unlimited


SEED_FILE="/users/mhb544/SALTED/salted/seeds.txt"
SEEDS=$(cat $SEED_FILE)


WORK_DIR="/users/mhb544/SALTED/example/Si_Gulliver"
ORIGINAL_SCRIPT="/users/mhb544/SALTED/salted/selection_functions.py"


### RUN YOUR CODE:
for SEED in $SEEDS; do
    echo "Running with seed $SEED"
    
    export SEED

    python -m salted.get_basis_info
    python -m salted.initialize
    python -m salted.sparse_selection
    srun --mpi=pmi2 -n 16 python -m salted.sparse_descriptor

    python -m salted.rkhs_projector
    srun --mpi=pmi2 -n 16 python -m salted.rkhs_vector

    srun --mpi=pmi2 -n 10 -c 2 python -m salted.hessian_matrix
    python -m salted.solve_regression
    srun --mpi=pmi2 -n 16 python -m salted.validation > validation_${SEED}.out

done
