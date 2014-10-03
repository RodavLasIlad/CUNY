library(shiny)
cdc <- read.csv("cleaned-cdc-mortality-1999-2010.csv")
# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Crude Mortality Rate by State"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    selectInput("cause", "Choose a mortality cause:",
                choices = names(table(cdc$ICD.Chapter))),
    submitButton("Update"),
    h5("Choose a mortality cause to see the states ranked in order of the crude rate of death for that cause.")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    # Height can be adjusted, but if it's too small, the state names will be on top of each other
    plotOutput("barPlot", height="800px")
  )
))
