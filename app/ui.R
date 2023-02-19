
if (!require("shiny")) {
  install.packages("shiny")
  library(shiny)
}
if (!require("shinyWidgets")) {
  install.packages("shinyWidgets")
  library(shinyWidgets)
}
if (!require("shinythemes")) {
  install.packages("shinythemes")
  library(shinythemes)
}
if (!require("leaflet")) {
  install.packages("leaflet")
  library(leaflet)
}
if (!require("leaflet.extras")) {
  install.packages("leaflet.extras")
  library(leaflet.extras)
}

if (!require("shinydashboard")) {
  install.packages("shinydashboard")
  library(shinydashboard)
}


# Define UI for application that draws a histogram
body <- dashboardBody(
  tabItems(
    # ------------------ Home ----------------------------------------------------------------
    
    tabItem(tabName = "Home", fluidPage(
      fluidRow(box(width = 15, title = "Introduction", status = "primary",
                   solidHeader = TRUE, h3("Crime Data for five Boroughs in NYC"),
                   h4("By Srushti Divyesh Sa ghavi, Mingrui Shi, Weijie Xia, YiXun Xu, Aubrey Yan, Dongxu Zhang"),
                   h5("A")
      )
      ),
      fluidRow(box(width = 15, title = "Targeted User", status = "primary", solidHeader=TRUE,
                   h5("We believe that the application would be useful for anyone who are planning to live in NYC"))),
      fluidRow(box(width = 15, title = "How to Use The App", status = "primary",
                   solidHeader = TRUE,
                   h5("The application is divided into 5 separate tabs"),
                   tags$div(tags$ul(
                     tags$li("The", strong("first"), "tab: Map can be clicked for detailed info"),
                     tags$li("The", strong("second"), "tab: A"),
                     tags$li("The", strong("third and fourth"), "tab: B"),
                     tags$li("The", strong("fifth"),"tab: C")
                     
                   ))
      ))
    )), # end of homepage
    tabItem(
      tabName = "Map",
      leafletOutput(outputId = "myMap", width = "100%", height = 750)
    )
  )
)

shinyUI(
    dashboardPage(
      title="Crimes in NYC",
      skin="purple",
      dashboardHeader(title=span("Crimes in NYC",style="font-size: 16px")),
      
      dashboardSidebar(sidebarMenu(
        menuItem("Home", tabName = "Home", icon = icon("home")),
        menuItem("Map", tabName = "Map", icon = icon("map-marker-alt")),
        menuItem("A", tabName = "A", icon = icon("dollar-sign")),
        menuItem("B", tabName = "B", icon = icon("dollar-sign")),
        menuItem("C", tabName = "C", icon = icon("fas fa-asterisk"))
      )),
      body
    )
) #Shiny UI closing    
