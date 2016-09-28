library(shiny)

shinyServer(input, output, session) {
  
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    states@data <- merge(states@data, subset(hom, year == input$range[1]))
    states
    #hom[hom$year == input$range[1] ,]
  })
  
  # This reactive expression represents the palette function,
  # which changes as the user makes selections in UI.
  colorpal <- reactive({
    colorNumeric("Reds", hom$rate)
  })
  
  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    states@data <- merge(states@data, subset(hom, year == 2015))
    pal <- colorpal()
    leaflet(states) %>% addTiles() %>%
      setView(-102, 23.8, 5) %>% 
      addLegend(position = "bottomright",
                pal = pal, values = ~hom$rate,
                title = "homicide<br>rate")
  })
  
  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  observe({
    pal <- colorpal()
    head(states@data)
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>%
      addPolygons(stroke = TRUE, weight = 1, color = "#000000",
                  fillOpacity = 0.8, smoothFactor = 0.5,
                  fillColor = ~pal(rate), 
                  popup = ~sprintf("State: %s<br/>Rate: %s",
                                    stri_trans_totitle(state), 
                                    round(rate, 1)))
  })
  
  
}
