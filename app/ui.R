
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
                   solidHeader = TRUE, h3("Crime Suspect Features for the Five Boroughs in NYC"),
                   h4("By Srushti Divyesh Sanghavi, Mingrui Shi, Weijie Xia, YiXun Xu, Aubrey Yan, Dongxu Zhang"),
                   h5("Introduction goes here")
      )
      ),
      fluidRow(box(width = 15, title = "Targeted User", status = "primary", solidHeader=TRUE,
                   h5("We believe that the application would be useful for anyone who is planning to live in NYC"))),
      fluidRow(box(width = 15, title = "How to Use The App", status = "primary",
                   solidHeader = TRUE,
                   h5("The application is divided into 5 separate tabs"),
                   tags$div(tags$ul(
                     tags$li("The", strong("first"), "tab: Map can be clicked for detailed info"),
                     tags$li("The", strong("second"), "tab: Reference")
                   ))
      ))
    )), # end of homepage
    tabItem(
      tabName = "Map",
      leafletOutput(outputId = "myMap", width = "100%", height = 750),
      #control panel on the left
      absolutePanel(id = "control", class = "panel panel-default", fixed = TRUE, draggable = TRUE,
                    top = 200, left = "auto", right = "auto", bottom = "auto", width = "200", height = "auto",
                    tags$h4('Graph by suspect features'), 
                    tags$br(),
                    awesomeRadio("feature", 
                                 label="Features",
                                 choices =c("Age",
                                            "Race", 
                                            "Sex"), 
                                 selected = "Age",
                                 status = "warning"),
                    style = "opacity: 0.70"
      )
    ),
    # ------------------ Reference --------------------------------
    tabItem(tabName = "Reference", fluidPage( 
      HTML(
        "<h2> Data Sources </h2>
                <h4> <p><li>NYC Crime Suspect Data: <a href='https://data.cityofnewyork.us/Public-Safety/NYPD-Complaint-Data-Current-Year-To-Date-/5uac-w243'>NYPD Complaint Data</a></li></h4>
                <h4><li>NYC Geo Data : <a href='https://data.cityofnewyork.us/City-Government/Borough-Boundaries/tqmj-j8zm'> NYC Borough Boundaries </a></li></h4>"
      ),
      
      titlePanel("Acknowledgement  "),
      
      HTML(
        "<p>This application is based on R and shiny app.</p>"
      ),
      
      titlePanel("Contributors"),
      
      HTML(
        " <p>Srushti Divyesh Sanghavi(@columbia.edu) </p>",
        " <p>Mingrui Shi(@columbia.edu)</p>",
        " <p>Weijie Xia(@columbia.edu) </p>",
        " <p>YiXun Xu(@columbia.edu)</p>",
        " <p>Aubrey Yan(@columbia.edu) </p>",
        " <p>Dongxu Zhang(dz2510@columbia.edu)</p>")
    )) # end of tab
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
      menuItem("Reference", tabName = "Reference", icon = icon("fas fa-asterisk"))
    )),
    body
  )
) #Shiny UI closing    
