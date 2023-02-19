# install.packages("shiny")
# install.packages("leaflet")

server = function(input,output, session){

output$boroughs_map = renderLeaflet({
  boroughs_map = leaflet()
  boroughs_map = addTiles(boroughs_map)
  boroughs_map = addPolygons(boroughs_map, data = boroughs, color = "Red", label = ~paste0(boro_name))
  })

}