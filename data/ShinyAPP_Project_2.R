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

## BRONX DATA ---- Use Bronx data for populating the charts in Shiny
bronx_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "BRONX")

# Suspect Age Group bar chart
bronx_data$SUSP_AGE_GROUP <- as.factor(bronx_data$SUSP_AGE_GROUP)

age_levels = c("<18", "18-24", "25-44", "45-64", "65+")
age_group_plot = bronx_data %>%
  count(SUSP_AGE_GROUP) %>%
  filter(SUSP_AGE_GROUP %in% age_levels) %>%
  ggplot(aes(x = reorder(SUSP_AGE_GROUP, - n), y = n)) +
  geom_col(fill = "Red") +
  ggtitle("Suspect Age group data for Bronx") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Age Group") + ylab("No. of Suspects")
  
# Suspect Race bar chart
bronx_data$SUSP_RACE <- as.factor(bronx_data$SUSP_RACE)

race_levels = c("AMERICAN INDIAN/ALASKAN NATIVE", "ASIAN / PACIFIC ISLANDER", "BLACK", "BLACK HISPANIC", "WHITE", "WHITE HISPANIC")
race_plot = bronx_data %>%
  count(SUSP_RACE) %>%
  filter(SUSP_RACE %in% race_levels) %>%
  ggplot(aes(x = reorder(SUSP_RACE, + n), y = n)) +
  geom_col(fill = "Blue") +
  ggtitle("Suspect Race data for Bronx") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Race") + ylab("No. of Suspects") +
  coord_flip()

# Suspect Sex pie chart
bronx_data$SUSP_SEX <- as.factor(bronx_data$SUSP_SEX)

sex_levels = c("F", "M", "U")
sex_plot = bronx_data %>%
  count(SUSP_SEX) %>%
  filter(SUSP_SEX %in% sex_levels) %>%
  mutate(perc = n / sum(n)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc)) %>%
  ggplot(aes(x = "", y = perc, fill = SUSP_SEX)) +
  geom_col(color = "black") +
  geom_label(aes(label = labels), color = c("white", "black", "white"),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  guides(fill = guide_legend(title = "Sex")) +
  scale_fill_viridis_d(labels=c('Female', 'Male', 'Unknown')) +
  coord_polar(theta = "y") +
  theme_void() +
  ggtitle("Suspect Sex data for Bronx")+
  theme(plot.title = element_text(hjust = 0.5))


###### Use Bronx data for populating the charts in Shiny #############



## MANHATTAN DATA
manhattan_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "MANHATTAN")

# Suspect Age Group bar chart
manhattan_data$SUSP_AGE_GROUP <- as.factor(manhattan_data$SUSP_AGE_GROUP)

age_levels = c("<18", "18-24", "25-44", "45-64", "65+")
manhattan_data %>%
  count(SUSP_AGE_GROUP) %>%
  filter(SUSP_AGE_GROUP %in% age_levels) %>%
  ggplot(aes(x = reorder(SUSP_AGE_GROUP, - n), y = n)) +
  geom_col(fill = "Red") +
  ggtitle("Suspect Age group data for Manhattan") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Age Group") + ylab("No. of Suspects")

# Suspect Race bar chart
manhattan_data$SUSP_RACE <- as.factor(manhattan_data$SUSP_RACE)

wanted_levels = c("AMERICAN INDIAN/ALASKAN NATIVE", "ASIAN / PACIFIC ISLANDER", "BLACK", "BLACK HISPANIC", "WHITE", "WHITE HISPANIC")
manhattan_data %>%
  count(SUSP_RACE) %>%
  filter(SUSP_RACE %in% wanted_levels) %>%
  ggplot(aes(x = reorder(SUSP_RACE, + n), y = n)) +
  geom_col(fill = "Blue") +
  ggtitle("Suspect Race data for Manhattan") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlab("Race") + ylab("No. of Suspects") +
  coord_flip()

# Suspect Sex pie chart
manhattan_data$SUSP_SEX <- as.factor(manhattan_data$SUSP_SEX)

wanted_levels = c("F", "M", "U")
manhattan_data %>%
  count(SUSP_SEX) %>%
  filter(SUSP_SEX %in% wanted_levels) %>%
  mutate(perc = n / sum(n)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc)) %>%
  ggplot(aes(x = "", y = perc, fill = SUSP_SEX)) +
  geom_col(color = "black") +
  geom_label(aes(label = labels), color = c("white", "black", "white"),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  guides(fill = guide_legend(title = "Sex")) +
  scale_fill_viridis_d(labels=c('Female', 'Male', 'Unknown')) +
  coord_polar(theta = "y") +
  theme_void() +
  ggtitle("Suspect Sex data for Manhattan")+
  theme(plot.title = element_text(hjust = 0.5))

## BROOKLYN DATA
brooklyn_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "BROOKLYN")

# Suspect Age Group bar chart
brooklyn_data$SUSP_AGE_GROUP <- as.factor(brooklyn_data$SUSP_AGE_GROUP)

wanted_levels = c("<18", "18-24", "25-44", "45-64", "65+")
brooklyn_data %>%
  count(SUSP_AGE_GROUP) %>%
  filter(SUSP_AGE_GROUP %in% wanted_levels) %>%
  ggplot(aes(x = reorder(SUSP_AGE_GROUP, - n), y = n)) +
  geom_col(fill = "Red") +
  ggtitle("Suspect Age group data for Brooklyn") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Age Group") + ylab("No. of Suspects")

# Suspect Race bar chart
brooklyn_data$SUSP_RACE <- as.factor(brooklyn_data$SUSP_RACE)

wanted_levels = c("AMERICAN INDIAN/ALASKAN NATIVE", "ASIAN / PACIFIC ISLANDER", "BLACK", "BLACK HISPANIC", "WHITE", "WHITE HISPANIC")
brooklyn_data %>%
  count(SUSP_RACE) %>%
  filter(SUSP_RACE %in% wanted_levels) %>%
  ggplot(aes(x = reorder(SUSP_RACE, + n), y = n)) +
  geom_col(fill = "Blue") +
  ggtitle("Suspect Race data for Brooklyn") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlab("Race") + ylab("No. of Suspects") +
  coord_flip()

# Suspect Sex pie chart
brooklyn_data$SUSP_SEX <- as.factor(brooklyn_data$SUSP_SEX)

wanted_levels = c("F", "M", "U")
brooklyn_data %>%
  count(SUSP_SEX) %>%
  filter(SUSP_SEX %in% wanted_levels) %>%
  mutate(perc = n / sum(n)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc)) %>%
  ggplot(aes(x = "", y = perc, fill = SUSP_SEX)) +
  geom_col(color = "black") +
  geom_label(aes(label = labels), color = c("white", "black", "white"),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  guides(fill = guide_legend(title = "Sex")) +
  scale_fill_viridis_d(labels=c('Female', 'Male', 'Unknown')) +
  coord_polar(theta = "y") +
  theme_void() +
  ggtitle("Suspect Sex data for Brooklyn")+
  theme(plot.title = element_text(hjust = 0.5))


## STATEN ISLAND DATA
statenIsland_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "STATEN ISLAND")

# Suspect Age Group bar chart
statenIsland_data$SUSP_AGE_GROUP <- as.factor(statenIsland_data$SUSP_AGE_GROUP)

wanted_levels = c("<18", "18-24", "25-44", "45-64", "65+")
statenIsland_data %>%
  count(SUSP_AGE_GROUP) %>%
  filter(SUSP_AGE_GROUP %in% wanted_levels) %>%
  ggplot(aes(x = reorder(SUSP_AGE_GROUP, - n), y = n)) +
  geom_col(fill = "Red") +
  ggtitle("Suspect Age group data for Staten Island") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Age Group") + ylab("No. of Suspects")

# Suspect Race bar chart
statenIsland_data$SUSP_RACE <- as.factor(statenIsland_data$SUSP_RACE)

wanted_levels = c("AMERICAN INDIAN/ALASKAN NATIVE", "ASIAN / PACIFIC ISLANDER", "BLACK", "BLACK HISPANIC", "WHITE", "WHITE HISPANIC")
statenIsland_data %>%
  count(SUSP_RACE) %>%
  filter(SUSP_RACE %in% wanted_levels) %>%
  ggplot(aes(x = reorder(SUSP_RACE, + n), y = n)) +
  geom_col(fill = "Blue") +
  ggtitle("Suspect Race data for Staten Island") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlab("Race") + ylab("No. of Suspects") +
  coord_flip()

# Suspect Sex pie chart
statenIsland_data$SUSP_SEX <- as.factor(statenIsland_data$SUSP_SEX)

wanted_levels = c("F", "M", "U")
statenIsland_data %>%
  count(SUSP_SEX) %>%
  filter(SUSP_SEX %in% wanted_levels) %>%
  mutate(perc = n / sum(n)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc)) %>%
  ggplot(aes(x = "", y = perc, fill = SUSP_SEX)) +
  geom_col(color = "black") +
  geom_label(aes(label = labels), color = c("white", "black", "white"),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  guides(fill = guide_legend(title = "Sex")) +
  scale_fill_viridis_d(labels=c('Female', 'Male', 'Unknown')) +
  coord_polar(theta = "y") +
  theme_void() +
  ggtitle("Suspect Sex data for Staten Island")+
  theme(plot.title = element_text(hjust = 0.5))


## QUEENS DATA
queens_data = crime_data %>%
  select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
  filter(BORO_NM == "QUEENS")

# Suspect Age Group bar chart
queens_data$SUSP_AGE_GROUP <- as.factor(queens_data$SUSP_AGE_GROUP)

wanted_levels = c("<18", "18-24", "25-44", "45-64", "65+")
queens_data %>%
  count(SUSP_AGE_GROUP) %>%
  filter(SUSP_AGE_GROUP %in% wanted_levels) %>%
  ggplot(aes(x = reorder(SUSP_AGE_GROUP, - n), y = n)) +
  geom_col(fill = "Red") +
  ggtitle("Suspect Age group data for Queens") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Age Group") + ylab("No. of Suspects")

# Suspect Race bar chart
queens_data$SUSP_RACE <- as.factor(queens_data$SUSP_RACE)

wanted_levels = c("AMERICAN INDIAN/ALASKAN NATIVE", "ASIAN / PACIFIC ISLANDER", "BLACK", "BLACK HISPANIC", "WHITE", "WHITE HISPANIC")
queens_data %>%
  count(SUSP_RACE) %>%
  filter(SUSP_RACE %in% wanted_levels) %>%
  ggplot(aes(x = reorder(SUSP_RACE, + n), y = n)) +
  geom_col(fill = "Blue") +
  ggtitle("Suspect Race data for Queens") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlab("Race") + ylab("No. of Suspects") +
  coord_flip()

# Suspect Sex pie chart
queens_data$SUSP_SEX <- as.factor(queens_data$SUSP_SEX)

wanted_levels = c("F", "M", "U")
queens_data %>%
  count(SUSP_SEX) %>%
  filter(SUSP_SEX %in% wanted_levels) %>%
  mutate(perc = n / sum(n)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc)) %>%
  ggplot(aes(x = "", y = perc, fill = SUSP_SEX)) +
  geom_col(color = "black") +
  geom_label(aes(label = labels), color = c("white", "black", "white"),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  guides(fill = guide_legend(title = "Sex")) +
  scale_fill_viridis_d(labels=c('Female', 'Male', 'Unknown')) +
  coord_polar(theta = "y") +
  theme_void() +
  ggtitle("Suspect Sex data for Queens")+
  theme(plot.title = element_text(hjust = 0.5))





