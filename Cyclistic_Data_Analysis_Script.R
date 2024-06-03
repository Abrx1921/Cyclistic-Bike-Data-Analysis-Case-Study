# Set wd, install/load packages and load dataset (csv) 

setwd("C:/Users/abrah/OneDrive/Documents/Data Projects/Divvy_Trips_2019_to_2020/Final Cyclistic Dataframe")
library(tidyverse)
bikedata <- read.csv("Cyclistic_Clean_Bikedata.csv")



# View Dataset

View(bikedata)
str(bikedata)
colnames(bikedata)
summary(bikedata)
head(bikedata)

# Dataset date range. Min/Max dates

daterange <- bikedata %>% 
  summarize(min_start_date = min(start_date), max_start_date = max(end_date))

print(daterange)


#Total Rides

total_rides <- bikedata %>% 
  count() %>% 
  rename(all_rides = n)

View(total_rides)

# Find the total number of rides between user types

all_usertypes <- bikedata %>% 
  count(usertype) %>% 
  rename(user_rides = n)

View(all_usertypes)

#Visualize the number of rides by user type (PieChart)

all_usertypes %>% 
  ggplot(aes(x = "", y = user_rides, fill = usertype)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  geom_text(aes(label = user_rides), 
            position = position_stack(vjust = 0.5), size = 4, color = "black") +
  coord_polar(theta = "y") +
  theme_void() +
  scale_fill_manual(values = c("CASUAL" = "gray", "MEMBER" = "lightblue")) +
  labs(fill = "Usertype") +
  theme(legend.title = element_text(face = "bold"))

# Percentage 

merged_rides_usertypes <- merge(total_rides, all_usertypes)

merged_rides_usertypes$percentage <- round((merged_rides_usertypes$user_rides / merged_rides_usertypes$all_rides) * 100, 2)

View(merged_rides_usertypes)

# Visualize the percentage

merged_rides_usertypes %>% 
  ggplot(aes(x = "", y = percentage, fill = usertype)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  geom_text(aes(label = paste0(percentage, "%")), 
            position = position_stack(vjust = 0.5), size = 4, color = "black") +
  coord_polar(theta = "y") +
  theme_void() +
  scale_fill_manual(values = c("CASUAL" = "gray", "MEMBER" = "lightblue")) +
  labs(fill = "Usertype") +
  theme(legend.title = element_text(face = "bold"))
 

# Trip Duration Average and Median 
avg_median <- bikedata %>% 
  summarise(average = round(mean(tripduration), 2), median = median(tripduration)) 

View(avg_median)

# Find the average trip duration by day of week

avg_med_tripduration <- bikedata %>% 
  group_by(day_of_week) %>% 
  summarise(average = round(mean(tripduration), 2), median = median(tripduration)) 

View(avg_med_tripduration)

# Visualize Average Trip duration by Day of Week
avg_med_tripduration %>% 
  ggplot() +
  geom_col(aes(x = day_of_week, y = average, fill = day_of_week), show.legend = FALSE) +
  geom_text(aes(x = day_of_week, y = average, label = average), 
            position = position_stack(vjust = .75), size = 4, color = "black") +
  scale_fill_brewer(palette = "set2") +
  labs(y = "Average Trip Duration", x = "") + 
  theme_minimal() +
  theme(axis.title.y = element_text(face = "bold")) 

# Visualize Median Trip duration by Day of the Week
avg_med_tripduration %>% 
  ggplot() +
  geom_col(aes(x = day_of_week, y = median, fill = day_of_week), show.legend = FALSE) +
  geom_text(aes(x = day_of_week, y = median, label = median), 
            position = position_stack(vjust = .75), size = 3.5, color = "black") +
  scale_fill_brewer(palette = "Set2") +
  labs(y = "Median Trip Duration", x = "") + 
  theme_minimal() +
  theme(axis.title.y = element_text(face = "bold")) 

# --------------------------------------------------------------
# Visualize Average and Median Trip Duration by Day of the Week (Stacked Bar Chart)
ggplot(avg_med_tripduration) +
  geom_col(aes(x = day_of_week, y = average, fill = "Average"), position = "dodge") +
  geom_text(aes(x = day_of_week, y = average, label = average), 
            position = position_dodge(width = 0.9), size = 3.5, color = "black") +
  geom_col(aes(x = day_of_week, y = median, fill = "Median"), position = "dodge") +
  geom_text(aes(x = day_of_week, y = median, label = median), 
            position = position_dodge(width = 0.9), size = 3.5, color = "black") +
  scale_fill_manual(values = c("Average" = "tan", "Median" = "lightgreen"), guide = "legend") +
  labs(y = "Trip Duration", x = "Day of the Week", fill = "Metric") + 
  theme_minimal() +
  theme(axis.title.y = element_text(face = "bold"))
# -----------------------------------------------------------



# Find the average trip duration by user type

usertype_avg_med <- bikedata %>% 
  group_by(usertype) %>% 
  summarise(avgs = round(mean(tripduration), 2), median = median(tripduration))  
  

View(usertype_avg_med)

# Visualization User type Avg Trip Duration (Bargraph)
usertype_avg_med %>% 
  ggplot() + 
  geom_col(aes(x = usertype, y = avgs, fill = usertype), show.legend = FALSE) +
  geom_text(aes(x = usertype, y = avgs, label = avgs), 
    position = position_stack(vjust = .75), size = 4, color = "black") +
  scale_fill_manual(values = c("CASUAL" = "gray", "MEMBER" = "lightblue")) +
  labs(y = "Average Trip Duration", x = "") + 
  theme_minimal() +
  theme(axis.title.y = element_text(face = "bold")) 

# Visualization User type Median Trip Duration (Bar Graph)
usertype_avg_med %>% 
  ggplot() + 
  geom_col(aes(x = usertype, y = median, fill = usertype), show.legend = FALSE) +
  geom_text(aes(x = usertype, y = median, label = median),
            position = position_stack(vjust = .75), size = 4, color = "black") +
  scale_fill_manual(values = c("CASUAL" = "gray", "MEMBER" = "lightblue")) +
  labs(y = "Median Trip Duration", x = "") + 
  theme_minimal() +
  theme(axis.title.y = element_text(face = "bold")) 



## Not important, just used it to check if there were a lot of people who rode more than 1 day but less than two. The result was less than 1,000

# Filter to see how long casual users ride (greater than 1440 minutes/Outliers)

tripcounts <- bikedata %>% 
  filter(usertype %in% c("CASUAL", "MEMBER"), tripduration > 1440) %>% 
  group_by(usertype) %>% 
  summarize(count = n()) %>% 
  pivot_wider(names_from = usertype, values_from = count, values_fill = list(count = 0)) # Different Columns for usertypes
  
View(tripcounts)



# What day of the week is the most popular 

popularday <- bikedata %>%
  group_by(day_of_week) %>% 
  summarize(num_of_rides = n()) %>% 
  arrange(-num_of_rides)
  

View(popularday)

# Organize day of week for visualization purposes
day_order <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday") #Set the order of days for the data set
popularday$day_of_week <- factor(popularday$day_of_week, levels = day_order) 


# Visualization of Most Popular day of the week
popularday %>% 
  ggplot() + #initialize ggplot
  geom_col(mapping = aes(x = day_of_week, y = num_of_rides, fill = day_of_week)) + # geom_col create bar graph/maps axis/fill determines color
  scale_fill_brewer(palette = "Set2") + # Lets you have pre-defined color palettes
  coord_cartesian(ylim = c(4e+05, max(popularday$num_of_rides))) + # Zooms in our plot
  labs(y = "Rides", x = "Weekdays", title = "Number of Rides per Day of the Week", fill = "Weekdays") + # Add labels
  theme_minimal() # Makes plot cleaner





# What day of the week is the most popular by user type

# Filter, group, summarize, and arrange the data
popularday_user <- bikedata %>%
  filter(usertype %in% c("MEMBER", "CASUAL")) %>%
  group_by(day_of_week, usertype) %>%
  summarize(num_of_rides = n(), .groups = 'drop') %>%
  pivot_wider(names_from = usertype, values_from = num_of_rides, values_fill = list(num_of_rides = 0))

View(popularday_user)

# Organize by day of the week
day_order <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
popularday_user$day_of_week <- factor(popularday_user$day_of_week, levels = day_order)
popularday_user <- popularday_user %>%
  arrange(day_of_week)

View(popularday_user)

# Convert to long format for plotting
popularday_user_long <- popularday_user %>%
  pivot_longer(cols = c(MEMBER, CASUAL), names_to = "usertype", values_to = "num_of_rides")

View(popularday_user_long)

# Plot the data with dodged bars
popularday_user_long %>%
  ggplot(aes(x = day_of_week, y = num_of_rides, fill = usertype)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("CASUAL" = "gray", "MEMBER" = "lightblue")) +
  labs(title = "Weekly Rides by Usertype", x = "Day of the Week", y = "Number of Rides", fill = "Usertype") +
  theme_minimal() +
  theme(legend.title = element_text(face = "bold")) 





# Top 5 Most popular stations
max_rows <- 5

top_5_stations <- bikedata %>% 
  group_by(from_station_name) %>% 
  summarize(total_rides = n()) %>% 
  arrange(-total_rides) %>% 
  top_n(max_rows)

View(top_5_stations)

# Summarize the number of rides by user type for the top stations
station_rides_by_user_type <- bikedata %>%
  filter(from_station_name %in% top_5_stations$from_station_name) %>%
  count(from_station_name, usertype)

# Visualize Top 5 Most Popular Stations
station_rides_by_user_type %>%
  ggplot(aes(x = from_station_name, y = n, fill = usertype)) +
  geom_col(position = position_dodge(width = 0.9)) +
  geom_text(aes(label = n), 
            position = position_dodge(width = 0.9), 
            size = 3, color = "black", vjust = -0.5) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Station Names", y = "Number of rides", fill = "User Type") +
  scale_fill_manual(values = c("MEMBER" = "lightblue", "CASUAL" = "gray"))






# Top 5 Most popular station for Members and Casual Users 

max_rows <- 5 # Limit to 5

popular_stations <- bikedata %>% 
  filter(usertype %in% c("CASUAL", "MEMBER")) %>% 
  group_by(usertype, from_station_name) %>% 
  summarize(num_of_rides = n()) %>% 
  arrange(usertype ,desc(num_of_rides)) %>% 
  group_by(usertype) %>% 
  top_n(max_rows)
 
View(popular_stations)

# Reorder from_station_name based on num_of_rides
popular_stations <- popular_stations %>%
  mutate(from_station_name = factor(from_station_name, levels = unique(from_station_name[order(num_of_rides, decreasing = TRUE)])))

# Visualize Top 5 Stations by Usertype

popular_stations %>% 
  ggplot() +
  geom_col(mapping = aes(x = from_station_name, y = num_of_rides, fill = usertype)) +
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  scale_fill_manual(values = c("MEMBER" = "lightblue", "CASUAL" = "gray")) +
  labs(x = "Station Names", y = "Number of Rides", fill = "Usertypes") 





# Most popular months among different user types

monthlyusers <- bikedata %>% 
  mutate(month = month(start_date, label = TRUE)) %>% # Month function extracts the month from the start_date column. 
  filter(usertype %in% c("CASUAL", "MEMBER")) %>% 
  group_by(usertype, month) %>% 
  summarize(num_of_rides = n()) %>% 
  pivot_wider(names_from = usertype, values_from = num_of_rides)

View(monthlyusers)

# Convert to long format for plotting
monthlyusers_long <- monthlyusers %>%
  pivot_longer(cols = c(MEMBER, CASUAL), names_to = "usertype", values_to = "num_of_rides")

View(monthlyusers_long)

# Visualize the rides by month by usertypes (Stacked Bar Graph)

monthlyusers_long %>% 
  ggplot() +
  geom_col(mapping = aes(x = month, y = num_of_rides, fill = usertype)) +
  scale_fill_manual(values = c("MEMBER" = "lightblue", "CASUAL" = "gray")) +
  coord_cartesian(ylim = c(1e+05, 6e+05)) + # Zooms in our plot 
  labs(x = "Month", y = "Number of Rides", fill = "Usertype") +
  theme(legend.title = element_text(face = "bold"))



  
# Average Age Demographic 

dataset_year <- 2020 # Actual user age relative to the year 2020

average_age <- bikedata %>% 
  filter(birthyear > 1950 & birthyear < 2005) %>% # Filtering for People ages 15 - 70 years old
  mutate(age = dataset_year - birthyear) %>% 
  group_by(usertype) %>%
  summarize(average_age = mean(age, na.rm = TRUE))

View(average_age)

# Age of all users 

user_age <- bikedata %>% 
  filter(birthyear > 1950 & birthyear < 2005) %>% 
  mutate(age = dataset_year - birthyear) %>%
  group_by(usertype, age) %>% # convert birth year to age
  summarize(num_of_users = n()) %>% 
  pivot_wider(names_from = usertype, values_from = num_of_users, values_fill = list(num_of_rides = 0))

View(user_age)


# Calculate the number of rides by age and user type
rides_by_age <- bikedata %>%
  filter(birthyear > 1950 & birthyear < 2005) %>% # Filtering for ages 15-70 years old
  mutate(age = dataset_year - birthyear) %>% # Calculate age
  group_by(usertype, age) %>% # Group by usertype and age
  summarize(num_of_rides = n(), .groups = 'drop') 


# Identify the top 5 age's with the maximum number of rides for each user type
maxrides_age <- rides_by_age %>%
  group_by(usertype) %>% # Group by usertype 
  top_n(5, num_of_rides) %>% 
  ungroup()

View(maxrides_age)


# Visualize age of all users by user type (Line Plot)

user_age %>% 
  ggplot() + 
  geom_line(mapping = aes(x = age, y = CASUAL, color = "Casual"), size = 1) + 
  geom_line(mapping = aes(x = age, y = MEMBER, color = "Member"), size = 1) +
  labs(x = "Age", y = "Total Rides", color = "User Type") +
  scale_color_manual(values = c("Casual" = "gray", "Member" = "lightblue"), labels = c("Casual", "Member")) 


