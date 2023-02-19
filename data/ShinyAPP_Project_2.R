rm(list = ls())

## Data of the five boroughs to be plotted on the Map
#install.packages('rgdal')

library(rgdal)
boroughs = readOGR("/Users/srushtisanghavi/Documents/COLUMBIA COURSEWORK/Spring 23/Applied Data Science/Assignment 2/Borough Boundaries.geojson")

## Data Analysis
# Crime data of NYC for 2022
library(dplyr)
library(ggplot2)
crime_data = read.csv("/Users/srushtisanghavi/Documents/COLUMBIA COURSEWORK/Spring 23/Applied Data Science/Assignment 2/2022_complaint_dataset.csv")

head(crime_data)

## BRONX DATA
bronx_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "BRONX")

# Suspect Age Group bar chart
bronx_data$SUSP_AGE_GROUP <- as.factor(bronx_data$SUSP_AGE_GROUP)

bronx_data %>%
  count(SUSP_AGE_GROUP) %>%
  filter(SUSP_AGE_GROUP == "<18" | SUSP_AGE_GROUP == "18-24" | SUSP_AGE_GROUP == "25-44" 
         | SUSP_AGE_GROUP == "45-64" | SUSP_AGE_GROUP == "65+") %>%
  ggplot(aes(x = SUSP_AGE_GROUP, y = n)) +
  geom_col(fill = "Red")
  

## Suspect

bronx_data$SUSP_RACE <- as.factor(bronx_data$SUSP_RACE)
bronx_data$SUSP_SEX <- as.factor(bronx_data$SUSP_SEX)
table(bronx_data$SUSP_RACE)
table(bronx_data$SUSP_SEX)

# Victim
bronx_data$VIC_AGE_GROUP <- as.factor(bronx_data$VIC_AGE_GROUP)
bronx_data$VIC_RACE<- as.factor(bronx_data$VIC_RACE)
bronx_data$VIC_SEX <- as.factor(bronx_data$VIC_SEX)

table(bronx_data$VIC_AGE_GROUP)
table(bronx_data$VIC_RACE)
table(bronx_data$VIC_SEX)

## MANHATTAN DATA
manhattan_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "MANHATTAN")

# Suspect
manhattan_data$SUSP_AGE_GROUP <- as.factor(manhattan_data$SUSP_AGE_GROUP)
manhattan_data$SUSP_RACE <- as.factor(manhattan_data$SUSP_RACE)
manhattan_data$SUSP_SEX <- as.factor(manhattan_data$SUSP_SEX)

table(manhattan_data$SUSP_AGE_GROUP)
table(manhattan_data$SUSP_RACE)
table(manhattan_data$SUSP_SEX)

# Victim
manhattan_data$VIC_AGE_GROUP <- as.factor(manhattan_data$VIC_AGE_GROUP)
manhattan_data$VIC_RACE<- as.factor(manhattan_data$VIC_RACE)
manhattan_data$VIC_SEX <- as.factor(manhattan_data$VIC_SEX)

table(manhattan_data$VIC_AGE_GROUP)
table(manhattan_data$VIC_RACE)
table(manhattan_data$VIC_SEX)

## BROOKLYN DATA
brooklyn_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "BROOKLYN")

# Suspect
brooklyn_data$SUSP_AGE_GROUP <- as.factor(brooklyn_data$SUSP_AGE_GROUP)
brooklyn_data$SUSP_RACE <- as.factor(brooklyn_data$SUSP_RACE)
brooklyn_data$SUSP_SEX <- as.factor(brooklyn_data$SUSP_SEX)

table(brooklyn_data$SUSP_AGE_GROUP)
table(brooklyn_data$SUSP_RACE)
table(brooklyn_data$SUSP_SEX)

# Victim
brooklyn_data$VIC_AGE_GROUP <- as.factor(brooklyn_data$VIC_AGE_GROUP)
brooklyn_data$VIC_RACE<- as.factor(brooklyn_data$VIC_RACE)
brooklyn_data$VIC_SEX <- as.factor(brooklyn_data$VIC_SEX)

table(brooklyn_data$VIC_AGE_GROUP)
table(brooklyn_data$VIC_RACE)
table(brooklyn_data$VIC_SEX)

## STATEN ISLAND DATA
statenIsland_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "STATEN ISLAND")

# Suspect
statenIsland_data$SUSP_AGE_GROUP <- as.factor(statenIsland_data$SUSP_AGE_GROUP)
statenIsland_data$SUSP_RACE <- as.factor(statenIsland_data$SUSP_RACE)
statenIsland_data$SUSP_SEX <- as.factor(statenIsland_data$SUSP_SEX)

table(statenIsland_data$SUSP_AGE_GROUP)
table(statenIsland_data$SUSP_RACE)
table(statenIsland_data$SUSP_SEX)

# Victim
statenIsland_data$VIC_AGE_GROUP <- as.factor(statenIsland_data$VIC_AGE_GROUP)
statenIsland_data$VIC_RACE<- as.factor(statenIsland_data$VIC_RACE)
statenIsland_data$VIC_SEX <- as.factor(statenIsland_data$VIC_SEX)

table(statenIsland_data$VIC_AGE_GROUP)
table(statenIsland_data$VIC_RACE)
table(statenIsland_data$VIC_SEX)

## QUEENS DATA
queens_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "QUEENS")

# Suspect
queens_data$SUSP_AGE_GROUP <- as.factor(queens_data$SUSP_AGE_GROUP)
queens_data$SUSP_RACE <- as.factor(queens_data$SUSP_RACE)
queens_data$SUSP_SEX <- as.factor(queens_data$SUSP_SEX)

table(queens_data$SUSP_AGE_GROUP)
table(queens_data$SUSP_RACE)
table(queens_data$SUSP_SEX)

# Victim
queens_data$VIC_AGE_GROUP <- as.factor(queens_data$VIC_AGE_GROUP)
queens_data$VIC_RACE<- as.factor(queens_data$VIC_RACE)
queens_data$VIC_SEX <- as.factor(queens_data$VIC_SEX)

table(queens_data$VIC_AGE_GROUP)
table(queens_data$VIC_RACE)
table(queens_data$VIC_SEX)





