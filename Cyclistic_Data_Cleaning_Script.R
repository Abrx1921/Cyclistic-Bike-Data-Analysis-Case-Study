setwd("C:/Users/abrah/OneDrive/Documents/Data Projects/Divvy_Trips_2019_to_2020/Final Cyclistic Dataframe")
library(tidyverse)
bikedata <- read_csv("Cyclistic_Bike_Data.csv")



# Scan the data

View(bikedata)
str(bikedata)
head(bikedata)
colnames(bikedata)
summary(bikedata)
dim(bikedata)



# Convert tripduration from seconds to minutes and round two decimal places

bikedata$tripduration <- round(bikedata$tripduration/60, digits = 2)



# Remove negative trip duration and trip durations exceeding two days

bikedata <- bikedata_original %>% 
  filter(tripduration > 0 & tripduration < 2880)



# Separate start_time and end_time columns into two column. (Date/Time)

bikedata <- separate(bikedata,"start_time",into=c('start_date','start_time'), sep=' ')
bikedata <- separate(bikedata,"end_time",into=c('end_date','end_time'), sep=' ')

    # or 

bikedata <- bikedata %>%
  mutate(end_date = as.Date(end_time),
         end_time = format(as.POSIXct(end_time), format = "%H:%M:%S"))



# Create a date of the week column for analysis

str(bikedata)

  #Change start_date/end_date data type to Date format
bikedata$start_date <- as.Date(bikedata$start_date)
bikedata$end_date <- as.Date(bikedata$end_date)

bikedata <- bikedata %>% 
  mutate(day_of_week = weekdays(start_date))

bikedata <- bikedata %>% 
  relocate(day_of_week, .after = 1)

  #Change start_time/end_time data type to Time format. 

bikedata$start_time <- as.POSIXct(bikedata$start_time)
bikedata$start_time <- format(bikedata$start_time, "%H:%M:%S")


bikedata$end_time <- as.POSIXct(bikedata$end_time)
bikedata$end_time <- format(bikedata$end_time, "%H:%M:%S")

# Change instances of Customer to Casual and Subscriber to Member (Uppercase)

bikedata <- bikedata %>% 
  mutate(usertype = gsub("Customer", "casual", usertype)) %>% 
  mutate(usertype = gsub("Subscriber", "member", usertype)) 

bikedata$usertype <- toupper(bikedata$usertype)

# Remove (*) character from station names to ensure consistency

bikedata <- bikedata %>%
  mutate(to_station_name = gsub("\\s*\\(\\*\\)\\s*", "", to_station_name)) %>% 
  mutate(from_station_name = gsub("\\s*\\(\\*\\)\\s*", "", from_station_name))

#Remove instances with (Temp) which could indicate temporary. 

rows_with_parenthesis <- grep("\\(Temp\\)", bikedata$from_station_name) # Instances with (Temp)
bikedata <- subset(bikedata, !grepl("Temp", from_station_name))

# Look at your new data frame

View(bikedata)

# Extract New Data frame for Analysis

write.csv(bikedata, file = "Cyclistic_Clean_Bikedata.csv", row.names = FALSE)

