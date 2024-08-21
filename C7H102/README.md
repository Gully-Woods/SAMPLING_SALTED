# USE 

-this folder should be added as a new directory within the subdirectory 'example' 

# C7H10O2.xyz 

-contains the atomic coordinate dataset for the different molecular isomers of C7H10O2 

# run-ML-diff.sbatch

-The following sbatch command will run the learning steps in the tutorial for one seed. Make sure that conditions are correct in selection_function.py

-validation.out will show the RMSE for this sampling method for one specific seed

-ml-setup-err will show any errors in the output
 
# run-ML-seeded-diff.sbatch

-The following sbatch command will run the learning steps in the tutorial in one command for all the seeds in seeds.txt. Make sure that conditions are correct in selection_function.py

-validation_seed.out will show the RMSE for this specific seed 

-ml-setup-err will show any errors in the output

