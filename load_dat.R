load_dat <- function(){
     training_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
     test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
     training_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
     test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
     training_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
     test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
     features <- readLines("./UCI HAR Dataset/features.txt")
     a <- list(training_set, 
              test_set, 
              training_activity, 
              test_activity, 
              training_subject, 
              test_subject, 
              features)
     return(a)
}