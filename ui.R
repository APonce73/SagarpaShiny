library(shiny)


shinyUI(bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                sliderInput("range", "Year", 1997, 2015,
                            value = 2015, step = 1, sep = "",
                            animate = animationOptions(interval = 3000, loop = FALSE, 
                                                       playButton = NULL,
                                                       pauseButton = NULL)
                )
  )
))