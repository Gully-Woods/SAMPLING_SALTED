# USE

These files should be added to the 'salted' folder within SALTED

# cleanup.sh 

This file is not strictly needed but saves time when trying to remove files from your dataset folders and navigate repeatedly afterwards to the salted directory. 

# seeds.txt 

This is a very important text file that reads the specific seeds that the sbatch script should iterate other. Each script should start the next tested 'seed' with a new line as seen bellow

This file is only in use for the seeded.sbatch scripts



# ** selection_functions.py **

-This file contains all the functions that should be read to sparse_selection.py

-In the case of wanting to iterate multiple seeds: leave 'for iteration' as is, leave 'seeded' as is for all the functions

-In the case of wanting to only use one selection such as in CUR decomposition: for the specific function of note change seeded to equal a specific value, comment out to avoid errors the section titled 'for iteration'

-In the case of only using one seed no variable should be left as seeded for the relevant function



# "**sparse_selection.py**" 

-In line 42 replace the do_* with the sampling function of choice


