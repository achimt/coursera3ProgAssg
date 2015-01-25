combine_dat <- function(frames){
     # we put each of the tables we have loaded
     # as a list into a suitably named variable
     training_set <- frames[[1]]
     test_set <- frames[[2]]
     training_activity <- frames[[3]]
     test_activity <- frames[[4]]
     training_subject <- frames[[5]]
     test_subject <- frames[[6]]
     features <- frames[[7]]
     # we get rid of the number at the beginning of the
     # features to turn them into column headers (using R regex)
     # see ?regex
     features <- gsub("^[[:digit:]]*[[:space:]]", "", features)
     # and then of the roundy brackets - they might become nasty as they
     # are special characters
     features <- gsub(")","",features)
     features <- gsub("\\(","_",features)
     # we set column names
     colnames(test_set) <- features
     colnames(training_set) <- features
     colnames(test_activity) <- "activity"
     colnames(training_activity) <- "activity"
     colnames(test_subject) <- "subject"
     colnames(training_subject) <- "subject"
     # and then put the whole dataset together
     test_set <- cbind(test_subject, test_activity, test_set)
     training_set <- cbind(training_subject, training_activity, training_set)
     data_set <- rbind(test_set, training_set)
     data_set
}