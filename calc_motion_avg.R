calc_motion_avg <- function(motion_dat){
     library(dplyr)
     motion_dat <- arrange(motion_dat, subject, activity)
     motion_dat <- motion_dat %>%
          group_by(subject, activity) %>%
          summarise_each(funs(mean))
     motion_dat     
}