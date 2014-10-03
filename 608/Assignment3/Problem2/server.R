library(shiny)
library(dplyr)
library(ggplot2)
# Load in the data
cdc <- read.csv("cleaned-cdc-mortality-1999-2010.csv")
# Filter so it's only using 2010's data

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  # Return the requested dataset
  datasetChoice <- reactive({
    # Filter by the chosen cause
   filter(cdc, ICD.Chapter == input$cause, State==input$state)
  })
  natlChoice <- reactive({
    # Finds the national average for the chosen disease
    natlChosen <- filter(cdc, ICD.Chapter == input$cause)
    aggregate(natlChosen[c("Population", "Deaths")], by=natlChosen["Year"], FUN=sum)
  })
  
  # Generate a summary of the dataset
  output$barPlot <- renderPlot({
    cdcChosen <- datasetChoice()
    # Some states did not record data for all twelve years (but judging from the data that is 
    # there, there was mortality) so I have excluded them completely as it would be unfair to make assumptions from only two of twelve years of data
    if (nrow(cdcChosen) == 12){
      natlAvg <- natlChoice()
      # Compares the national average to the state
      cdcChosen["compareNatl"] <- cdcChosen$Crude.Rate - ((natlAvg$Deaths/natlAvg$Population) * 100000)
      
      # Plotting:

      ggplot(data=cdcChosen, aes(x=factor(Year), y=compareNatl, fill=Crude.Rate)) + 
        geom_bar(stat="identity", position = position_dodge(width=10)) + 
        coord_flip() + 
        ylab("Crude Mortality Rate") + 
        xlab("Year") +
        ggtitle(paste(input$cause, "compared to the national average")) +
        theme_bw()
    }
    # Not ideal, but this way nothing has to be changed in the ui file
    else {
      # Plots so that it is still returned
      par(mar = c(0,0,0,0))
      plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
      text(x = 0.5, y = 0.5, "Not enough data available\nFor a proper comparison", 
           cex = 1.6, col = "black")
    }
  })
})