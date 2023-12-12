#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(plotly)
ui <- fluidPage(
  theme = shinytheme("cerulean"), 

  titlePanel("Taylor Swift Audio Features Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("feature1", "Choose the first Audio Feature:",
                  choices = c("Danceability", "Energy", "Valence", "Acousticness", "Loudness", "Instrumentalness", "Speechiness", "Tempo", "Popularity", "Liveness")),
      selectInput("feature2", "Choose the second Audio Feature:",
                  choices = c("Danceability", "Energy", "Valence", "Acousticness", "Loudness", "Instrumentalness", "Speechiness", "Tempo", "Popularity", "Liveness")),
      selectInput("selectedAlbum", "Select an Album:",
                  choices = c("All", unique(taylor_swift_data$album))),
    ),
    
    mainPanel(
      plotlyOutput("featurePlot")
    )
  )
)


server <- function(input, output) {
  # Reactive expression to filter data based on selected album
  filteredData <- reactive({
    if(input$selectedAlbum == "All") {
      taylor_swift_data
    } else {
      taylor_swift_data[taylor_swift_data$album == input$selectedAlbum, ]
    }
  })
  
  output$featurePlot <- renderPlotly({
    # Mapping the input to actual column names in your data
    feature_map <- c(Danceability = "danceability", 
                     Energy = "energy", 
                     Valence = "valence", 
                     Acousticness = "acousticness", 
                     Loudness = "loudness",
                     Instrumentalness= "instrumentalness",
                     Speechiness= "speechiness",
                     Tempo = "tempo",
                     Liveness = "liveness",
                     Popularity = "popularity")
    
    feature1 <- feature_map[input$feature1]
    feature2 <- feature_map[input$feature2]
    
    # Creating the ggplot
    p <- ggplot(filteredData(), aes(x = !!sym(feature1), y = !!sym(feature2), 
                                    text = paste(name, album, sep = " - "))) +
      geom_point(color = "skyblue") +
      labs(x = input$feature1, y = input$feature2) +
      theme_minimal()
    
    # Convert to plotly object
    ggplotly(p, tooltip = "text")
  })
}




# Run the application 
shinyApp(ui = ui, server = server)
