# Getting-and-Cleaning-Data-project
Course project for Getting and Cleaning Data

Hi and welcome to my assignment for the online course "Getting and cleaning of data"

You will find 4 files within this repo. 
  1. Readme.md - what you reading 
  2. run_analysis.R - the code of the assignment, please read below for an explanation about how the script works
  3. 3. Codebook.txt - Containing information about 
    * Information about the variables (including units!) in the data set not contained in the tidy data
    * Information about the summary choices you made
    * Information about the experimental study design you used
  4. averagebysubjectactivity.txt - Forming the output dataset of the assignment. 
    * This file lists the average of a large number of variables for each subject and activity
    * Please refer to the codebook for more information about the variables in the source and summary data.

  ##run_analysis.R
The script follows the following steps 
1. Reading of data files, including column headings, activity labels, as well as data files including test and training data, and subject and activity listings.
2. To reduce the size of the data, the test and training datasets are reduced to only include the columns containing measurements on the mean and standard deviation
3. Activity names and subject information are merged into the test and training datasets 
4. At this point, the test and training datasets are merged into a single 'Combined dataset'
5. The column headings of the combined dataset are then reformatted and renamed  
6. Finally, the combined dataset is summarised by activity and subject to produce the final tidy dataset 



