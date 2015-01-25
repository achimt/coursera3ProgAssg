# coursera3ProgAssg
This is a set of R files created to prepare the "Human Activity Recognition Using Smartphones Dataset Version 1.0" for further analysis

It contains the following files:

- run_analysis.R	- an R script that produces a summary file from the UCI HAR dataset. This script calls all the other functions in the order given below. 
- load_dat.R 		- an R function that loads all the data files and returns them in a list
- combine_dat.R 	- an R function that combines the data files from this list into one data frame
- xtract_columns.R 	- an R function that extracts from the data frame columns with info on mean and standard deviation of measured variables in the UCI HAR dataset
- calc_motion_avg.R 	- an R function that summarises the columns in the previously created clean dataset by their mean

- README.md		- this file
- CodeBook.md		- a detailed description of the data cleaning process