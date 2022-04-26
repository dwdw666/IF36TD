#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(dplyr)
# Define UI for application 

ui <- dashboardPage(
  dashboardHeader(title = "Star Wars"),
  dashboardSidebar( sidebarMenu(
    menuItem("stats", tabName = "stats", icon = icon("dashboard")),
    menuItem("Widgets", tabName = "widgets", icon = icon("th")),
    sliderInput("rateThreshold", "nb individus",
                min = 0, max = 87, value = 10, step = 10
    ),
    selectInput("select", label = h3("color for distibution"), 
                choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                selected = 1)
  )),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "stats",
              # A static valueBox fix
              valueBox(42, "New Orders", icon = icon("list"),color="blue"),
              
              # Dynamic valueBoxes
              valueBoxOutput("individus"),
              
              valueBoxOutput("dimentions"),
              # Dynamic infoBoxes
              infoBoxOutput("Average_height"),
              
              # Dynamic infoBoxes
              infoBoxOutput("Median_mass"),
      ),
      
      # Second tab content
      tabItem(tabName = "graphique",
              h2("Widgets tab content")
      )
    )
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  dim = dim(starwars)
  
  average_height = mean(starwars$height,na.rm = TRUE)
  
  median_mass = median(starwars$mass,na.rm = TRUE)
  
  output$individus <- renderValueBox({
    valueBox(
      paste0(input$rateThreshold), "individu", icon = icon("list"),
      color = "red"
    )
  })
  output$dimentions <- renderValueBox({
    valueBox(
      paste0(dim[2]), "dimentions", icon = icon("list"),
      color = "yellow"
    )
  })
  output$Average_height <- renderInfoBox({
    infoBox(
      "average height", paste0(average_height), icon = icon("list"),
      color = "purple"
    )
  })
  output$Median_mass <- renderInfoBox({
    infoBox(
      "average height", paste0(median_mass), icon = icon("list"),
      color = "purple"
    )
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
