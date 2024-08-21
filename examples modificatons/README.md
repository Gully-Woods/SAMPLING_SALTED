# ** inp.yaml **

Each dataset folder should have an inp.yaml file the contents of which should change depending on the dataset although water should remain fundamentally unchanged.



-Set parallel to 'True'

-C7H10O2 and Si should have the relevant species replace to [C,H,O] and [Si] respectively

-The filepath should match in sections such as filename
 
-Gaussian process regression is where most test variables are located

-A variable called gradtol can be added and changed for C7H10O2






# ** run-aims.sbatch **

-each folder should have this file

-change the directory paths as per the chosen directory names for the datasets






# !! WARNING !! 

For the step hessian_matrix, the number of tasks set by srun -n multiplied by blocksize in inp.yaml has to equal Ntrain in inp.yaml
