rm(list = ls())

## Data of the five boroughs to be plotted on the Map
#install.packages('rgdal')

library(rgdal)
boroughs = readOGR("/Users/srushtisanghavi/Documents/COLUMBIA COURSEWORK/Spring 23/Applied Data Science/Assignment 2/Borough Boundaries.geojson")


