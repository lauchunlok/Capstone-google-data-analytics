library("tidyverse")
library("ggplot2")
library("dplyr")
library("lubridate")

setwd("C:/Users/chunl/Desktop/Google Data Analytics/Case Study 2/archive/Fitabase Data 4.12.16-5.12.16")

# dailyActivity_merged cover all the data in dailyCalories_merged, dailyIntensities_merged and dailySteps_merged
daily_activity <- read.csv("daily_level/dailyActivity_merged.csv") 
sleep_day <- read.csv("daily_level/sleepDay_merged.csv")

## Exploring a few key tables
head(daily_activity)
colnames(daily_activity)

head(sleep_day)
colnames(sleep_day)

#How many unique participants are there in each dataframe?
n_distinct(daily_activity$Id)
n_distinct(sleep_day$Id)

#How many observations are there in each dataframe?
nrow(daily_activity)
nrow(sleep_day)

## Understanding some summary statistics

daily_activity %>%  
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes) %>%
  summary()


sleep_day %>%  
  select(TotalSleepRecords,
         TotalMinutesAsleep,
         TotalTimeInBed) %>%
  summary()

#What's the relationship between steps taken in a day and sedentary minutes?
ggplot(data=daily_activity, aes(x=TotalSteps, y=SedentaryMinutes)) + geom_point() +
  geom_smooth()

#What's the relationship between minutes asleep and time in bed?
ggplot(data=sleep_day, aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) + geom_point()

## Merging these two datasets together
combined_data <- merge(sleep_day, daily_activity, by="Id")
n_distinct(combined_data$Id)

# Note that there were more participant Ids in the daily activity dataset that have been filtered out using merge. 
# Consider using 'outer_join' to keep those in the dataset. 
# Now you can explore some different relationships between activity and sleep as well. 
# For example, do you think participants who sleep more also take more steps or fewer steps per day? Is there a relationship at all? 
ggplot(data=combined_data, aes(x=TotalMinutesAsleep, y=TotalSteps)) + geom_point() + geom_smooth()
# How could these answers help inform the marketing strategy of how you position this new product?















   