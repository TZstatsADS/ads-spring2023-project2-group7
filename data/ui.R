
ui = fluidPage(
  # Application Title
  titlePanel("NYC Crime Statistics for each borough"),
  
  # Showing the Map
  mainPanel(
    leafletOutput("boroughs_map")
            )
)

