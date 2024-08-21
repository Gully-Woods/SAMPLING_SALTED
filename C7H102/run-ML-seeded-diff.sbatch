#!/bin/bash -l

# Standard output and error:
#SBATCH -o ./ML-water-%j.out
#SBATCH -e ./ML-setup-%j.err

# Initial working directory:
#SBATCH -D ./

# Job Name:
#SBATCH -J ML-water

# Queue (Partition):
#SBATCH --partition=nodes

# Number of nodes and tasks:
#SBATCH --nodes=1
#SBATCH --ntasks=16

# for OpenMP:
#SBATCH --cpus-per-task=1

# Memory usage of the job [MB], 3800 MB per task:
#SBATCH --mem-per-cpu=3800

# Notification and limit settings:
#SBATCH --mail-type=none
#SBATCH --time=48:00:00

# Purge any previously loaded modules
module purge

# Load modules
module load intel Python
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi2.so

ulimit -s unlimited


SEED_FILE="/users/mhb544/SALTED/salted/seeds.txt"
SEEDS=$(cat $SEED_FILE)

WORK_DIR="/users/mhb544/SALTED/example/water_monomer_AIMS"
ORIGINAL_SCRIPT="/users/mhb544/SALTED/salted/selection_functions.py"


### RUN YOUR CODE:

for SEED in $SEEDS; do
    echo "Running with seed $SEED"

    export SEED

    # Run your Python scripts
    python -m salted.get_basis_info
    python -m salted.initialize
    python -m salted.sparse_selection
    srun --mpi=pmi2 -n 16 python -m salted.sparse_descriptor

    python -m salted.rkhs_projector
    srun --mpi=pmi2 -n 16 python -m salted.rkhs_vector

    srun --mpi=pmi2 -n 16 python -m salted.minimize_loss
    srun --mpi=pmi2 -n 16 python -m salted.validation > validation_${SEED}.out
done

