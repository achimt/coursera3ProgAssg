# run_analysis.R
# for coursera course 3 Programming Assignment
activityDataFrames <- load_dat()
activityDataSet <- combine_dat(activityDataFrames)
activityDataSet <- xtract_columns(activityDataSet)
summarisedActivity <- calc_motion_avg(activityDataSet)
write.table(summarisedActivity, 
            file = "~//coursera//c3w3_project//summarisedActivity.txt",
            row.names = FALSE)
