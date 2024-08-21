#! /bin/bash -l

#SBATCH -o ./gen_data.out.%j
#SBATCH -e ./gen_data.err.%j
#SBATCH -J gen_data
#SBATCH --partition=nodes
#SBATCH --nodes=1
#SBATCH --ntasks=25
#SBATCH --mem-per-cpu=2000
#SBATCH --cpus-per-task=1
#SBATCH --time=1:00:00

export OMP_NUM_THREADS=1
ulimit -s unlimited

module purge

module load intel Python
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi2.so

export OMP_NUM_THREADS=1
ulimit -s unlimited

ROOT_DIR="/users/mhb544/SALTED/example/water_monomer_AIMS"
QMDIR="${ROOT_DIR}"
DATADIR="${QMDIR}/data"
AIMS=/users/mhb544/SALTED/aims.x


n=$(ls $DATADIR/geoms | grep -c 'in')

for (( i=1; i<=$n; i++ )); do
	mkdir ${DATADIR}/$i
	cp control.in ${DATADIR}/$i
	cp ${DATADIR}/geoms/$i.in ${DATADIR}/$i/geometry.in
	cd ${DATADIR}/$i

	srun --exclusive --mpi=pmi2 -n 1 $AIMS < /dev/null > aims.out && mv  rho_rebuilt_ri.out rho_df.out && mv ri_restart_coeffs.out ri_restart_coeffs_df.out &

	cd -
done

wait
