
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
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  tabItems(
    # ------------------ Home ----------------------------------------------------------------
    
    tabItem(tabName = "Home", fluidPage(
      fluidRow(box(width = 15, title = "Introduction", status = "primary",
                   solidHeader = TRUE, h3("Crime Suspect Features for the Five Boroughs in NYC"),
                   h4("By Srushti Divyesh Sanghavi, Mingrui Shi, Weijie Xia, YiXun Xu, Aubrey Yan, Dongxu Zhang"),
                   h5("Welcome to our interactive crime map app! We are excited to share with you this tool that will allow you to explore crime data in New York City in a unique and informative way.
Crime data can be overwhelming and difficult to interpret, but our app simplifies the process by providing an intuitive and interactive visual representation of crime incidents across the city's five boroughs. With just a few clicks, you can view aggregated information on crime records in each borough and drill down to explore specific details, such as suspect gender, age group, and race.
We believe that our app will be of great value to a variety of users, from concerned citizens looking to stay informed about crime in their communities to researchers and policymakers seeking to analyze trends and patterns.
We hope you find our app informative and easy to use. Thank you for using our app and we appreciate any feedback you may have to help us improve our tool.")
      )
      ),
      fluidRow(box(width = 15, title = "Targeted User", status = "primary", solidHeader=TRUE,
                   h5("Our app is designed for anyone who is interested in exploring crime data in New York City. Whether you are a concerned citizen, a journalist, or a researcher, our app provides an interactive and informative way to explore crime data.
For concerned citizens, our app can provide insight into crime patterns and trends in their neighborhoods, allowing them to take proactive steps to protect themselves and their communities. For journalists, our app can be a valuable tool for investigating crime stories and uncovering new angles. And for researchers, our app can provide a rich source of data for academic studies and analysis.
Regardless of your background or interests, our app is designed to make crime data more accessible and engaging, empowering you to explore and understand the data in new ways. So, whether you're a data enthusiast or just looking to stay informed, we invite you to dive in and explore the fascinating world of crime data in New York City."))),
      fluidRow(box(width = 15, title = "Instructions", status = "primary",
                   solidHeader = TRUE,
                   tags$div(tags$ul(
                     tags$li("Click on the second button on the left to open the map."),
                     tags$li("Use the buttons on the top left of the map to zoom in or out."),
                     tags$li("Use the EDA section to explore the distribution of suspect gender, age group, and race for the selected borough."),
                     tags$li("Click on a borough to see aggregated information on total crime records for that borough."),
                     tags$li("Click the third button on the left to access the references.")
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
                                 choices =c("Crime Desc",
                                            "Age",
                                            "Race", 
                                            "Sex"),
                                 selected = "Crime Desc",
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
        "<p>This application is based on R and shiny app. We would like to express our sincere gratitude to the New York City Police Department (NYPD) for providing us with the necessary data to develop this application. We would also like to thank the NYC Open Data platform for hosting the data. Finally, we would like to acknowledge the valuable contribution of our team members who worked tirelessly to develop and improve this application.</p>"
      ),
      
      titlePanel("Contributors"),
      
      HTML(
        " <p>Srushti Divyesh Sanghavi(ss6594@columbia.edu) </p>",
        " <p>Mingrui Shi(@columbia.edu)</p>",
        " <p>Weijie Xia(wx2281@columbia.edu) </p>",
        " <p>YiXun Xu(yx2740@columbia.edu)</p>",
        " <p>Aubrey Yan(xy2543@columbia.edu) </p>",
        " <p>Dongxu Zhang(dz2510@columbia.edu)</p>")
    )) # end of tab
  )
)

shinyUI(
  dashboardPage(
    skin="purple",
    dashboardHeader(title="NYC Crime Explorer"),
    
    dashboardSidebar(sidebarMenu(
      menuItem("Home", tabName = "Home", icon = icon("home")),
      menuItem("Map", tabName = "Map", icon = icon("map-marker-alt")),
      menuItem("Reference", tabName = "Reference", icon = icon("fas fa-asterisk"))
    )),
    body
  )
) #Shiny UI closing    
