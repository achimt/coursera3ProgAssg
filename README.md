# coursera3ProgAssg
This is a set of R files created to prepare the "Human Activity Recognition Using Smartphones Dataset Version 1.0" for further analysis.

It contains the following files:

- run_analysis.R	- an R script that produces a summary file from the UCI HAR dataset. This script calls all the other functions in the order given below. 
- load_dat.R 		- an R function that loads all the data files and returns them in a list
- combine_dat.R 	- an R function that combines the data files from this list into one data frame
- xtract_columns.R 	- an R function that extracts from the data frame columns with info on mean and standard deviation of measured variables in the UCI HAR dataset
- calc_motion_avg.R 	- an R function that summarises the columns in the previously created clean dataset by their mean
- README.md		- this file
- CodeBook.md		- a detailed description of the data cleaning process

All of these steps are carried out by the R script "run_analysis.R" that calls 4 functions that carry out the individual steps. All of the files assume that they and their working directory are located in the same directory as the directory containing the UCI HAR dataset. 

## Files and Dependencies
### run_analysis.R
This script needs the four functions 'load_dat.R', 'combine_dat.R', 'xtract_columns.R', 'calc_motion_avg.R'. 
It is run from the R command prompt by sourcing it with the command:
source('$PATH_TO DIRECTORY/calc_motion_avg.R')
### load_dat.R
This script assumes that it is located in the same directory as the UCI HAR data directory. 
It is called from the run_analysis.R script. 
### combine_dat.R
No dependencies. 
This script is called from the run_analysis.R script. 
### xtract_columns.R
This script calls the libraries 'plyr' and 'dplyr'. 
It is called from the run_analysis.R script. 
### calc_motion_avg.R
This script calls the library 'dplyr'. 
It is called from the run_analysis.R script. 

## Variables and Data  
### run_analysis.R
- activityDataFrames 	- list of dataframes obtained from load_dat()
- activityDataSet 	- dataframe obtained from calling combine_dat(activityDataFrames). This dataset is transformed into a data table that only contains means and standard deviations of measured variables by calling xtract_columns(activityDataFrames). 
- summarisedActivity 	- data table obtained from calculating the averages of each variable groubed by activity and subject. 

### load_dat.R
- training_set		- 7352 x 561 data frame containing measurements from the UCI HAR training dataset
- test_set 		- 2947 x 561 data frame containing measurements from the UCI HAR test dataset
- training_activity 	- 7352 x 1 data frame containing activity codes from the UCI HAR training dataset in one column
- test_activity		- 2947 x 1 data frame containing activity codes from the UCI HAR test dataset in one column
- training_subject 	- 7352 x 1 data frame containing subject codes from the UCI HAR training dataset in one column
- test_subject 		- 2947 x 1 data frame containing subject codes from the UCI HAR test dataset in one column
- features		- character vector containing descriptions for the measurements in the UCI HAR dataset

### combine_dat.R
- frames 			- list of 7 data frames containing all the data
- training_set		- 7352 x 561 data frame containing measurements from the UCI HAR training dataset
- test_set 		- 2947 x 561 data frame containing measurements from the UCI HAR test dataset
- training_activity 	- 7352 x 1 data frame containing activity codes from the UCI HAR training dataset in one column
- test_activity		- 2947 x 1 data frame containing activity codes from the UCI HAR test dataset in one column
- training_subject 	- 7352 x 1 data frame containing subject codes from the UCI HAR training dataset in one column
- test_subject 		- 2947 x 1 data frame containing subject codes from the UCI HAR test dataset in one column
- features		- character vector containing 561 descriptions for the measurements in the UCI HAR dataset
- data_set		- 10299 x 563 data frame containing annotated measurements from the reunited UCI HAR dataset

### xtract_columns.R
- data_set		- 10299 x 563 data frame containing annotated measurements from the reunited UCI HAR dataset
- features		- character vector containing 563 descriptions for the measurements in the UCI HAR dataset
- match_cols		- integer vector containing the indices of the 68 columns containing Stdev and Mean of measurements in the UCI HAR dataset
- motion_dat		- 10299 x 68 data table containing only Stdev and Mean of measurements in the UCI HAR dataset

### calc_motion_avg.R
- motion_dat	- 10299 x 68 data table containing only Stdev and Mean of measurements in the UCI HAR dataset. This data table is subsequently transformed into a 360 x 68 data table, averaging the Means and Stdevs of all measurements

## Transformations
### run_analysis.R
This is the master script calling the functions coded into the other scripts. It writes the resulting data table as a tsv file into the working directory. 
### load_dat.R
load_dat() is a function that loads from the UCI HAR dataset all the data that are relevant for the assignment. It generates a list containing 6 data frames and one vector. 
### combine_dat.R
combine_dat.R pulls the constituent data frames out of the list 'frames' and stores them in separate variables. 
The character vector containing measurement description gets a first cleanup removing the column numbers at the beginning of each description. This is followed by a removal of the brackets () in the descriptions. Both of these steps are performed using the regex command **gsub**. 

Using **cbind**, the columns containing subject IDs and activity IDs are merged with the measurement data frames. 

Using **rbind**, the training data frame and the test data frame are merged. The resulting data frame us returned. 

### xtract_columns.R
The data frame generated in combine_dat is converted into a data table motion_dat (this could have been done earlier). 

The **grep** command is used to find the column indices containing the substrings 'mean_' and 'std' in the UCI HAR dataset. Grepping for 'mean_' rather than 'mean' achieves that only the means of measurements are collected (otherwise some other columns would have been caught, that contain weighted averages of frequency components). 

Using the column indeces of columns that are to be retained, motion_dat is subsetted in situ. 

The variable names are then turned into a more legible (if very long) version using the REGEX command **gsub**.

The 'subject' and 'activity' columns that contain IDs as integer vectors are converted into factors. 

The activity IDs are subsequently converted into descriptions using the plyr command mapvalues. 

### calc_motion_avg.R
calc_motion_avg uses the dplyr command **summarise** (preceded by group_by) to generate in situ a data table that contains measurement averages of each activity for each subject, resulting in a datatable with 68 fields and 360 observations. 