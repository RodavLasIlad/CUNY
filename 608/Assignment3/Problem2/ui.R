library(shiny)
cdc <- read.csv("cleaned-cdc-mortality-1999-2010.csv")
# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Crude Mortality Rate by State compared to National Average"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    selectInput("cause", "Choose a mortality cause:",
                choices = names(table(cdc$ICD.Chapter))),
    selectInput("state", "Choose a state:",
                choices = names(table(cdc$State))),
    submitButton("Update"),
    h5("Choose a mortality cause and a state to see how that states mortality rate (per cause) is compared to the national average.")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("barPlot", height="600px")
  )
))
