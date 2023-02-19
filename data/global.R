# When you run your app, global.R runs first and loads everything in that file to the global R session environment. I personally find it easier to do everything that has to be done before the app starts in global.R. So now, in order to launch the base app, we have to put some code in all the files.

library(shiny)
library(leaflet)
library(dplyr)