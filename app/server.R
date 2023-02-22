#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
###############################Install Related Packages #######################
if (!require("shiny")) {
    install.packages("shiny")
    library(shiny)
}
if (!require("leaflet")) {
    install.packages("leaflet")
    library(leaflet)
}
if (!require("leaflet.extras")) {
    install.packages("leaflet.extras")
    library(leaflet.extras)
}
if (!require("dplyr")) {
    install.packages("dplyr")
    library(dplyr)
}
if (!require("magrittr")) {
    install.packages("magrittr")
    library(magrittr)
}
if (!require("mapview")) {
    install.packages("mapview")
    library(mapview)
}
if (!require("leafsync")) {
    install.packages("leafsync")
    library(leafsync)
}
if (!require("rgdal")) {
    install.packages("rgdal")
    library(rgdal)
}
if (!require("leafpop")) {
    install.packages("leafpop")
    library(leafpop)
}
if (!require("sf")) {
    install.packages("sf")
    library(sf)
}
if (!require("geojsonsf")) {
    install.packages("geojsonsf")
    library(geojsonsf)
}
if (!require("ggplot2")) {
    install.packages("ggplot2")
    library(ggplot2)
}

#Data Processing

boroughs <- geojson_sf("../data/Borough Boundaries.geojson")

crime_data <- read.csv("../data/2022_complaint_dataset")

pal <- colorBin("RdYlBu", domain = 1:5)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    ## Map Tab section
    # Function for generation a popup based on the area clicked by the user
    makePopupPlot <- function (clickedArea, df, feature) {
        # prepare the df for ggplot
        target_data = df %>%
            select(BORO_NM, OFNS_DESC, SUSP_AGE_GROUP, SUSP_RACE, SUSP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX) %>%
            filter(BORO_NM == toupper(clickedArea))
        
        if (feature =='Age') {
            # Suspect Age Group bar chart
            target_data$SUSP_AGE_GROUP <- as.factor(target_data$SUSP_AGE_GROUP)
            
            # plot <- bronx_data %>%
            #     count(SUSP_AGE_GROUP) %>%
            #     filter(SUSP_AGE_GROUP == "<18" | SUSP_AGE_GROUP == "18-24" | SUSP_AGE_GROUP == "25-44" 
            #            | SUSP_AGE_GROUP == "45-64" | SUSP_AGE_GROUP == "65+") %>%
            #     ggplot(aes(x = SUSP_AGE_GROUP, y = n)) +
            #     xlab("Age") +
            #     ylab("Count") +
            #     geom_col(fill = "Red") +
            #     geom_bar(position="stack", stat="identity", width = 0.9) +
            #     coord_flip() +
            #     ggtitle(paste0("Score overview in ", clickedArea)) + 
            #     theme(legend.position = "none") +
            #     theme(plot.margin = unit(c(0,0.5,0,0), "cm"), plot.title = element_text(size = 15)) 
            
            age_levels = c("<18", "18-24", "25-44", "45-64", "65+")
            age_group_plot = target_data %>%
                count(SUSP_AGE_GROUP) %>%
                filter(SUSP_AGE_GROUP %in% age_levels) %>%
                ggplot(aes(x = reorder(SUSP_AGE_GROUP, - n), y = n)) +
                geom_col(fill = "Red") +
                ggtitle(paste0("Suspect Age group Statistics:", clickedArea)) +
                theme(plot.title = element_text(hjust = 0.5)) +
                xlab("Age Group") + ylab("No. of Suspects")
            
            return (age_group_plot)
        }
        else if (feature =='Race') {
            target_data$SUSP_RACE <- as.factor(target_data$SUSP_RACE)
            race_levels = c("AMERICAN INDIAN/ALASKAN NATIVE", "ASIAN / PACIFIC ISLANDER", "BLACK", "BLACK HISPANIC", "WHITE", "WHITE HISPANIC")
            race_plot = target_data %>%
                count(SUSP_RACE) %>%
                filter(SUSP_RACE %in% race_levels) %>%
                ggplot(aes(x = reorder(SUSP_RACE, + n), y = n)) +
                geom_col(fill = "Blue") +
                ggtitle(paste0("Suspect Race group Statistics:", clickedArea)) +
                theme(plot.title = element_text(hjust = 0.5)) +
                xlab("Race") + ylab("No. of Suspects") +
                coord_flip()
            return (race_plot)
        }
        else {
            sex_levels = c("F", "M", "U")
            sex_plot = target_data %>%
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
                ggtitle(paste0("Suspect Sex group Statistics:", clickedArea))+
                theme(plot.title = element_text(hjust = 0.5))
        }
    }
    
    # create foundational map
    foundational.map <- reactive({
        p <- as.list(NULL)
        p <- lapply(1:nrow(boroughs), function(i) {
            p[[i]] <- makePopupPlot(boroughs$boro_name[i], crime_data, input$feature)
        })
        leaflet(options = leafletOptions(dragging = T, minZoom = 10, maxZoom = 16)) %>%
            setView(lng = -73.92,lat = 40.72, zoom = 10) %>%
            addTiles() %>%
            addProviderTiles("CartoDB.Positron") %>%
            addPolygons(data = boroughs, # Add the borough boundaries
                        fillColor = ~pal(strtoi(boroughs$boro_code)),
                        color = "Black",
                        weight = 2,
                        fillOpacity = 0.5,
                        group = "test",
                        layerId = ~boro_code,
                        highlightOptions = highlightOptions(color='white',weight=1,bringToFront = TRUE),
                        popup = popupGraph(p, width = 400, height = 300))
        #addPopupGraphs(list(p), group = "test", width = 500, height = 200, type="svg")
    })
    
    
    output$myMap <- renderLeaflet({
        foundational.map()
        
    }) # end of leaflet::renderLeaflet({})
    
    
})
