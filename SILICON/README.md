# USE 

-this folder should be added as a new directory within the subdirectory 'example' within SALTED

# Si_coords.xyz 

-contains the atomic coordinate dataset for the Silicon dataset 

# run-ml-CUR.sbatch

-This script will run all the learning steps in the tutorial to produce a RMSE for the specific seed. This will not work if seeded parameters are wrong in selection_functions.py

-validation.out will show the RMSE for this sampling method for one specific seed

-ml-setup-err will show any errors in the output
 
# run-ml.sbatch

-The following sbatch command will run the learning steps in the tutorial in one command for all the seeds in seeds.txt. Make sure that conditions are correct in selection_function.py

-validation_seed.out will show the RMSE for this specific seed 

-ml-setup-err will show any errors in the output

# IMPORTANT

make sure for the step hessian_matrix, the number of tasks set by srun -n multiplied by  blocksize in inp.yaml equals Ntrain in inp.yaml 
