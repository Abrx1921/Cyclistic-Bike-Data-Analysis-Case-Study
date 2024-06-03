# Take a look at my five different datasets

# Load the tidyverse
library(tidyverse)

# Set my directory so R can pull them from the correct folder
setwd("C:/Users/abrah/OneDrive/Documents/Data Projects/Divvy_Trips_2019_to_2020")

# Load 2019 Q1 Dataframe
Q1_2019 <- read_csv("Divvy_Trips_2019_Q1.csv")

# Look at the column names for 2019 Q1
colnames(Q1_2019)

# Take a look at the information of the dataframe
View(Q1_2019)

# Load 2019 Q2 Dataframe
Q2_2019 <- read_csv("Divvy_Trips_2019_Q2.csv")

# Look at the column names for 2019 Q1
colnames(Q2_2019)

# Take a look at the information of the dataframe
View(Q2_2019)

# Change Column Names for Q2_2019 to match those of Q1_2019

colnames(Q2_2019) <- c("trip_id", "start_time", "end_time", 
                       "bikeid", "tripduration", "from_station_id", 
                       "from_station_name", "to_station_id", "to_station_name", 
                       "usertype", "gender", "birthyear")

# Attempt to combine the dataframes into a single dataframe 

bike_data <- rbind(Q1_2019, Q2_2019)
View(bike_data) # Dataframe binding was a success!!!



# Load 2019 Q3 Dataframe
Q3_2019 <- read_csv("Divvy_Trips_2019_Q3.csv")

# Look at the column names for 2019 Q1
colnames(Q3_2019)

# Take a look at the information of the dataframe
View(Q3_2019)



# Load 2019 Q4 Dataframe
Q4_2019 <- read_csv("Divvy_Trips_2019_Q4.csv")

# Look at the column names for 2019 Q1
colnames(Q4_2019)

# Take a look at the information of the dataframe
View(Q4_2019)



# Load 2020 Q1 Dataframe
Q1_2020 <- read_csv("Divvy_Trips_2020_Q1.csv")

# Look at the column names for 2020 Q1
colnames(Q1_2020)

# Take a look at the information of the dataframe
View(Q1_2020)

# Change Column Names for Q1_2020 to match those of Q1_2019

# colnames(Q1_2020) <- c("ride_id", "rideable_type","started_at" ,
                       "ended_at", "start_station_name", "start_station_id",
                       "end_station_name", "end_station_id", "start_lat",
                       "start_lng", "end_lat", "end_lng", "member_casual")

# Change the column names using the which() function. 

# Find the index
index_start <- which(colnames(Q1_2020) == "started_at")

# Replace the column name
colnames(Q1_2020)[index_start] <- "start_time"
         
# Check replacement View
View(Q1_2020) #Replacement Success!!! Do this for all the column names needed. 

# Replacing all columns needed. 
index <- which(colnames(Q1_2020) == "trip_id") #overwrite the dataframe

# Replace the column name
colnames(Q1_2020)[index] <- "ride_id"



# Merge Q1/Q2 with Q3 and Q4 for 2019

bike_data <- rbind(Q1_2019, Q2_2019, Q3_2019, Q4_2019)
View(bike_data) # Data frame binding was a success!!!



# Drop columns from 2020 Q1 that are not in 2019

colnames(Q1_2020)
colnames(bike_data)

Q1_2020 <- Q1_2020 %>% 
  select(-rideable_type, -start_lat, -start_lng, -end_lat, -end_lng)

# View Dropped Column
View(Q1_2020)



# Drop columns from bike_data that are not in 2020 Q1

colnames(Q1_2020)
colnames(bike_data)

bike_data_2 <- bike_data %>% 
  select()
# Nothing was dropped, as it will all be used.

# View Dropped Column
View(Q1_2020)
View(bike_data_2)



# Add a column to 2020 called trip duration.
Q1_2020 <- Q1_2020 %>% 
  mutate(tripduration = end_time - start_time)

# View Added Column
View(Q1_2020)

# Change trip duration 2020 to numeric!
Q1_2020 <- Q1_2020 %>% 
  mutate(tripduration = as.numeric(end_time - start_time))



# Ensure data types for bike_data (q1-q4 2019) match with q1_2020
str(bike_data)
str(Q1_2020)



# drop more columns that aren't needed

Q1_2020 <- Q1_2020 %>% 
  select(- ride_length)

View(Q1_2020)



# Now I want to merge bike_data and Q1_2020, use bind_rows!

bikedata_complete <- bind_rows(bike_data, Q1_2020)
View(bikedata_complete) #success!!



#Ensure there are no duplicates, if there are, get rid of them!

      # Check for duplicates in the 'trip_id' and 'ride_id' column of bike_data
duplicates_logical <- duplicated(bikedata_complete[, c("trip_id", "ride_id", "Id")])

      # Count the number of duplicates
num_duplicates <- sum(duplicates_logical)

      # Print the result
if (num_duplicates > 0) {
  print(paste("Number of duplicates:", num_duplicates))
  
      # View the duplicated rows
  duplicated_rows <- bikedata_complete[duplicates_logical, ]
  View(duplicated_rows)
} else {
  print("No duplicates found based on trip_id.")
} # No duplicates found in our new df!



# create a new column called ID with random identifiers using uuid package

install.packages("uuid")
library(uuid)

bikedata_complete$ID <- UUIDgenerate(nrow(bikedata_complete))
View(bikedata_complete)

# Create shorter identifiers

# Function to generate random alphanumeric string of given length
generate_random_id <- function(length) {
  chars <- c(0:9, letters, LETTERS)
  paste0(sample(chars, length, replace = TRUE), collapse = "")
}

# Add a new column with random alphanumeric IDs of length 6
bikedata_complete$Id <- replicate(nrow(bikedata_complete), generate_random_id(6))



#Place Id column at the beginning of df.

    # Extract the column you want to move
Id <- bikedata_complete$Id


    # Remove the column from the dataframe
bikedata_complete <- bikedata_complete[, !names(bikedata_complete) %in% "Id"]

    # Place the column at the beginning
bikedata_complete <- cbind(Id, bikedata_complete)



# Remove columns to finalize dataframe

bikedata_complete <- bikedata_complete %>% 
  select(-Id_column)

colnames(bikedata_complete)
View(bikedata_complete)

# Export bikedata_complete as Csv file
write.csv(bikedata_complete, file = "Cyclisitc_Bike_Data.csv", row.names = FALSE)
