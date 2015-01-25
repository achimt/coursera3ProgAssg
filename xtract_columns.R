xtract_columns <- function(data_set){
     library(plyr)
     library(dplyr)
     motion_dat <- tbl_df(data_set)
     features <- names(data_set) # get the column names
     match_cols <- sort(c(1:2
                    , grep("mean_", features, fixed=T) # find columns with 'mean', but not 'meanFreq'
                    , grep("std", features, fixed=T)   # and columns with 'std'
                    ))                                 # and keep first 2 cols
     
     motion_dat <- motion_dat[,match_cols]            # extract these cols
     
     # improve variable names
     features <- names(motion_dat)
     features <- gsub("^t", "Time_Domain_", features)
     features <- gsub("^f", "Freq_Domain_", features)
     features <- gsub("Body", "Body_",features)
     features <- gsub("Acc", "Acceleration_", features)
     features <- gsub("Gravity", "Gravity_", features)
     features <- gsub("Gyro", "Gyroscope_", features)
     features <- gsub("Jerk", "Jerk_", features)
     features <- gsub("Mag", "Magnitude_", features)
     features <- gsub("-mean_", "Mean", features)
     features <- gsub("-std_", "StdDev", features)
     features <- gsub("Mean-", "Mean_", features)
     features <- gsub("StdDev-", "StdDev_", features)
     colnames(motion_dat) <- features
     
     # change subject and activity into factors
     motion_dat$subject <- as.factor(motion_dat$subject)
     motion_dat$activity <- as.factor(motion_dat$activity)
     motion_dat$activity <- mapvalues(motion_dat$activity,      # use descriptive activity names
               from = c("1","2","3","4","5","6"),
               to = c("WALKING", "UPSTAIRS", "DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
     motion_dat
}