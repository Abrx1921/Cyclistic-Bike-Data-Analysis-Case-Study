# Case Study: Cyclistic Bike Data Analysis 
**R Data Analysis Project**
<a name="top"></a>

**Author: Abraham Saenz Sigala**

**Date: June 2, 2024**

##

### The Phases of Data Analysis

#### 1. Ask :thought_balloon:

#### 2. Prepare :package:

#### 3. Process :soap:

#### 4. Analyze :test_tube:

#### 5. Share :bar_chart:

#### 6. Act :clapper:

### Scenario

You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share
company in Chicago. The director of marketing believes the company’s future success
depends on maximizing the number of annual memberships. Therefore, your team wants to
understand how casual riders and annual members use Cyclistic bikes differently. From these
insights, your team will design a new marketing strategy to convert casual riders into annual
members. But first, Cyclistic executives must approve your recommendations, so they must be
backed up with compelling data insights and professional data visualizations.


## 1. Ask

Ask Questions!

Three questions will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

:flashlight: **Business Task: Design a marketing strategy from insights gained in order to convert casual riders to annual members.**

Primary Stakeholders: Director of marketing Lily Moreno (Manager) and the Cyclistic Executive Team.

Secondary Stakeholders: Cyclistic Marketing Analytics Team

## 2. Prepare

Data needed in order to answer your questions!

[Data Source](https://divvy-tripdata.s3.amazonaws.com/index.html) and [License](https://divvybikes.com/data-license-agreement)

The data set used ranges from January 1, 2019 (Q1) to April 2, 2020 (Q1). It contains a combination of 5 CSVs, totaling 15 columns and 4.2 million rows.

:pencil: Data Passes ROCCC Approach:

- Reliable: Lyft Bikes and Scooters, LLC (“Bikeshare”) operates the City of Chicago’s (“City”) Divvy bicycle sharing service. Bikeshare and the City are committed to supporting bicycling as an alternative transportation option. As part of that commitment, the City permits Bikeshare to make certain Divvy system data owned by the City (“Data”) available to the public

- Original: Data has been made available by Motivate International Inc. (Note: Cyclistic is a fictional company. For the purposes of this case study, the datasets are appropriate and will enable you to answer the business questions.)

- Comprehensive: Data includes comprehensive information in columns and rows for analysis. 

- Current: Data is up to date. (April 2024)

- Cited: Bikeshare hereby grants to you a non-exclusive, royalty-free, limited, perpetual license to access, reproduce, analyze, copy, modify, distribute in your product or service and use the Data for any lawful purpose ([License](https://divvybikes.com/data-license-agreement)).


:construction: Dataset Limitations:

Our data lacks identification to differentiate between frequent casual users and tourists, potentially affecting marketing strategies and user behavior patterns. Additionally, null values and inconsistent entries were present but had negligible impact on our analysis post data cleaning. Future data collection should have consistent naming conventions implemented to facilitate and ensure effective insights and company success.

## 3. Process

Clean data is the best data. You will need to clean up data to get rid of any errors, inaccuracies, or inconsistencies.

:hammer_and_wrench: Tool: R (Packages: Tidyverse)

:dna: **Merge Data Sets for Cleaning:**

File: [Data Merging](Cyclistic_Data_Merging_Script.R)

:soap: **Cleaning Dataset for Analysis:**

File: [Data Cleaning](Cyclistic_Data_Cleaning_Script.R)

:floppy_disk: Export Cyclistic Cleaned Bike Data for Analysis

## 4. Analyze

You will want to think analytically about your data. At this stage you might sort and
format your data to make it easier to perform calculations, combine data from multiple sources and create tables with your results!

🛠️ Tool: R (Packages: Tidyverse)

:microscope: Analyze the Data to Discover Insights

File: [Data Analysis](Cyclistic_Data_Analysis_Script.R)

## 5. Share

🛠️ Tool: R Markdown (Packages: Tidyverse, Lubridate, knitr, DT, gridExtra) 

File: [R Markdown](Cyclistic_BikeData_RMD.RMD)

:bar_chart: [Data Analysis Report](https://rpubs.com/Abrx1921/1191923) 

<img src="https://github.com/Abrx1921/Cyclistic-Bike-Data-Analysis-Case-Study/assets/167746532/e8588db9-9cf3-443c-9da9-402add7bd728" width="350" height="450">

## 6. Act

### Actionable Insights:

:bulb: **Conclusions**

##

- Members constitute a substantial portion of our user base, comprising 78.15% of our total users. It’s important to acknowledge that converting every Casual user may not be feasible, as our data set doesn’t distinguish between locals who use our service without subscribing and tourists. However, we can implement marketing strategies to introduce our service to tourists. Additionally, there’s a significant opportunity to convert a portion of our Casual users and attract new users through incentivized initiatives.

- Average trip duration increases substantially during the weekends.

- Casual users on average seem to have a longer trip duration compared to Members.

- Casual users ages 25 - 31 use our service the most. This upward trend begins at around age 20 and begins to drop off steadily at age 40.

- Top 5 Most popular stations for both Casuals and Members are responsible for more than 50,000 rides individually.

- Most popular stations for Casual users include: Streeter Dr & Grand Ave, Lake Shore Dr & Monroe St, Millennium Park, Michigan Ave & Oak St and Shedd Aquarium.

- The most active months are from June to September for both Members and Casual riders. We do see a drop off during the colder months from November to February.

##

:clapper: **Recommendations**

##

Weekend Promotions for Casual Users:

- Strategy: Offer promotional incentives such as discounts at local eateries, cafes, and stores for riders who sign up for memberships during weekends.

- Execution: Promote these offers through social media, local hotspots, and in-app notifications starting Friday mornings. Collaborate with local businesses for joint promotions, providing mutual benefits and greater reach.

Student Promotions:

- Strategy: Introduce a student pass or referral program to highlight the value of our service and encourage future adoption of annual memberships.

- Execution: Partner with universities and student organizations to spread the word. Utilize social media platforms for targeted advertising. Offer initial sign-up incentives, such as free rides during the first month, to encourage trial and adoption. Educate students on the benefits and savings of becoming annual members.

Summer Marketing Strategy:

- Strategy: Offer a discounted pass during the first summer month or the first week of each summer month to encourage casual users to become annual members.

- Execution: Launch a summer marketing campaign across social media, local radio, and outdoor advertising (posters or billboards). Collaborate with local tourism boards to promote the service to visitors. Send targeted emails to previous casual users and unsubscribed members informing them of summer deals.

Marketing at Popular Stations:

- Strategy: Implement marketing strategies such as QR codes, on-site promotions, and attractive signage at the most popular stations to incentivize sign-ups.

- Execution: Design eye-catching posters and banners for these stations. Schedule staff presence during peak times, especially weekends and summer months, to provide information on savings and benefits, as well as assistance. Track the effectiveness of these promotions by monitoring membership sign-ups at these locations, allowing for data-driven adjustments and improvements.

Trip Duration Marketing:

- Strategy: Offer special benefits for users who ride for a certain amount of time.

- Execution: Promote these offers through the app, posters, and other types of media highlighting riding milestones. Partner with businesses to provide discounted benefits or free rides for users who surpass certain riding milestones. Create a rewards program for users who ride for long durations, use the service multiple times a day, or achieve specific milestones.

[Back to top](#top)
