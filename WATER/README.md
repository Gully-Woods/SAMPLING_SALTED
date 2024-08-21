# USE

this folder will already exist in the SALTED repository under water_monomer_AIMS we will only be adding to this directory

# run-ml-seeded.sbatch

-The following sbatch command will run the learning steps in the tutorial in one command for all the seeds in seeds.txt. Make sure that conditions are correct in selection_function.py

-validation_seed.out will show the RMSE for this specific seed 

-ml-setup-err will show any errors in the output

# ** run-ml.sbatch **

-This script will run all the learning steps in the tutorial to produce a RMSE for the learning. This will not work if seeded parameters are wrong in selection_functions.py

-validation.out will show the RMSE for this sampling method for one specific seed

-ml-setup-err will show any errors in the output

# IMPORTANT

##### make sure for the step hessian_matrix, the number of tasks set by srun -n multiplied by  blocksize in inp.yaml equals Ntrain in inp.yaml .


 
